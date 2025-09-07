import 'dart:math';
import 'package:easy_scanner/models/document_model.dart';
import 'package:easy_scanner/services/database_service.dart';

class SampleDataService {
  static final Random _random = Random();
  
  static final List<String> _sampleNames = [
    'Invoice_2024_001',
    'Receipt_Amazon_Purchase',
    'Contract_Agreement',
    'Bank_Statement_March',
    'Insurance_Policy',
    'Tax_Document_2024',
    'Medical_Report',
    'Utility_Bill_Electric',
    'Warranty_Certificate',
    'ID_Card_Copy',
    'Passport_Scan',
    'Rental_Agreement',
    'Work_Certificate',
    'Academic_Transcript',
    'Travel_Itinerary',
  ];

  static final List<String> _sampleTags = [
    'Important',
    'Finance',
    'Medical',
    'Legal',
    'Personal',
    'Work',
    'Tax',
    'Insurance',
    'Bills',
    'Receipts',
  ];

  static Future<void> generateSampleDocuments() async {
    try {
      final documents = <DocumentModel>[];
      final now = DateTime.now();

      for (int i = 0; i < 15; i++) {
        final createdDate = now.subtract(Duration(days: _random.nextInt(365)));
        final modifiedDate = createdDate.add(Duration(hours: _random.nextInt(24)));
        
        final document = DocumentModel(
          id: 'sample_${i}_${DateTime.now().millisecondsSinceEpoch}',
          name: _sampleNames[i % _sampleNames.length],
          filePath: '/storage/documents/sample_$i.pdf',
          thumbnailPath: '/storage/thumbnails/sample_$i.jpg',
          createdAt: createdDate,
          modifiedAt: modifiedDate,
          pageCount: _random.nextInt(10) + 1,
          fileSize: _random.nextInt(5000000) + 100000, // 100KB to 5MB
          tags: _sampleTags[_random.nextInt(_sampleTags.length)],
          isFavorite: _random.nextBool(),
        );

        documents.add(document);
      }

      // Save all documents to database
      for (final document in documents) {
        await DatabaseService.saveDocument(document);
      }

      print('✅ Generated ${documents.length} sample documents');
    } catch (e) {
      print('❌ Error generating sample documents: $e');
    }
  }

  static Future<void> clearSampleData() async {
    try {
      await DatabaseService.deleteAllDocuments();
      print('✅ Cleared all sample documents');
    } catch (e) {
      print('❌ Error clearing sample documents: $e');
    }
  }

  static Future<void> regenerateSampleData() async {
    await clearSampleData();
    await generateSampleDocuments();
  }
}