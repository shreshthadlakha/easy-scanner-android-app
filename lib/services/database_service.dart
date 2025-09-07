import 'package:hive_flutter/hive_flutter.dart';
import 'package:easy_scanner/models/document_model.dart';

class DatabaseService {
  static const String _documentsBoxName = 'documents';
  static Box<DocumentModel>? _documentsBox;

  static Future<void> initDatabase() async {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DocumentModelAdapter());
    }
    
    // Open boxes
    _documentsBox = await Hive.openBox<DocumentModel>(_documentsBoxName);
  }

  static Box<DocumentModel> get documentsBox {
    if (_documentsBox == null || !_documentsBox!.isOpen) {
      throw Exception('Documents box is not initialized. Call initDatabase() first.');
    }
    return _documentsBox!;
  }

  // CRUD Operations
  static Future<void> saveDocument(DocumentModel document) async {
    await documentsBox.put(document.id, document);
  }

  static DocumentModel? getDocument(String id) {
    return documentsBox.get(id);
  }

  static List<DocumentModel> getAllDocuments() {
    return documentsBox.values.toList();
  }

  static Future<void> updateDocument(DocumentModel document) async {
    await documentsBox.put(document.id, document);
  }

  static Future<void> deleteDocument(String id) async {
    await documentsBox.delete(id);
  }

  static Future<void> deleteAllDocuments() async {
    await documentsBox.clear();
  }

  // Search and filter operations
  static List<DocumentModel> searchDocuments(String query) {
    if (query.isEmpty) return getAllDocuments();
    
    final lowerQuery = query.toLowerCase();
    return documentsBox.values
        .where((doc) => 
            doc.name.toLowerCase().contains(lowerQuery) ||
            (doc.tags?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  static List<DocumentModel> getDocumentsByDateRange(DateTime start, DateTime end) {
    return documentsBox.values
        .where((doc) => 
            doc.createdAt.isAfter(start) && 
            doc.createdAt.isBefore(end))
        .toList();
  }

  static List<DocumentModel> getFavoriteDocuments() {
    return documentsBox.values
        .where((doc) => doc.isFavorite)
        .toList();
  }

  // Statistics
  static int get totalDocuments => documentsBox.length;
  
  static int get totalFileSize {
    return documentsBox.values
        .fold(0, (sum, doc) => sum + doc.fileSize);
  }

  // Database maintenance
  static Future<void> compactDatabase() async {
    await documentsBox.compact();
  }

  static Future<void> closeDatabase() async {
    await _documentsBox?.close();
    _documentsBox = null;
  }
}