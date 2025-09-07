import 'package:hive/hive.dart';

part 'document_model.g.dart';

@HiveType(typeId: 0)
class DocumentModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String filePath;

  @HiveField(3)
  String thumbnailPath;

  @HiveField(4)
  DateTime createdAt;

  @HiveField(5)
  DateTime modifiedAt;

  @HiveField(6)
  int pageCount;

  @HiveField(7)
  int fileSize;

  @HiveField(8)
  String? tags;

  @HiveField(9)
  bool isFavorite;

  DocumentModel({
    required this.id,
    required this.name,
    required this.filePath,
    required this.thumbnailPath,
    required this.createdAt,
    required this.modifiedAt,
    this.pageCount = 1,
    this.fileSize = 0,
    this.tags,
    this.isFavorite = false,
  });

  // Helper getters
  String get displayName => name.isEmpty ? 'Untitled Document' : name;
  
  String get formattedSize {
    if (fileSize < 1024) return '${fileSize}B';
    if (fileSize < 1024 * 1024) return '${(fileSize / 1024).toStringAsFixed(1)}KB';
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
  
  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(createdAt);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }

  // Copy with method for updates
  DocumentModel copyWith({
    String? id,
    String? name,
    String? filePath,
    String? thumbnailPath,
    DateTime? createdAt,
    DateTime? modifiedAt,
    int? pageCount,
    int? fileSize,
    String? tags,
    bool? isFavorite,
  }) {
    return DocumentModel(
      id: id ?? this.id,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      pageCount: pageCount ?? this.pageCount,
      fileSize: fileSize ?? this.fileSize,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}