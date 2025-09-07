// document_model.dart
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
  List<String> tags;

  DocumentModel({
    required this.id,
    required this.name,
    required this.filePath,
    required this.thumbnailPath,
    required this.createdAt,
    required this.modifiedAt,
    this.pageCount = 1,
    this.tags = const [],
  });

  // Helper methods
  String get displayName => name.isEmpty ? 'Untitled Document' : name;
  
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
}

// MANUAL document_model.g.dart (if build_runner fails)
// Create this as a separate file: document_model.g.dart

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DocumentModelAdapter extends TypeAdapter<DocumentModel> {
  @override
  final int typeId = 0;

  @override
  DocumentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DocumentModel(
      id: fields[0] as String,
      name: fields[1] as String,
      filePath: fields[2] as String,
      thumbnailPath: fields[3] as String,
      createdAt: fields[4] as DateTime,
      modifiedAt: fields[5] as DateTime,
      pageCount: fields[6] as int,
      tags: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, DocumentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.filePath)
      ..writeByte(3)
      ..write(obj.thumbnailPath)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.modifiedAt)
      ..writeByte(6)
      ..write(obj.pageCount)
      ..writeByte(7)
      ..write(obj.tags);
  }
}