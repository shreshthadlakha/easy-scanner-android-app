import 'package:flutter/foundation.dart';
import 'package:easy_scanner/models/document_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DocumentProvider extends ChangeNotifier {
  List<DocumentModel> _documents = [];
  List<DocumentModel> get documents => _documents;


  // TODO: Add methods to interact with DocumentService
}


final documentProvider = ChangeNotifierProvider((ref) {
  return DocumentProvider();
});
