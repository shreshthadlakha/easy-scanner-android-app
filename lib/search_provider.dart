import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SearchProvider extends ChangeNotifier {
  String _query = '';
  String get query => _query;


  void setSearchQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }
}


final searchProvider = ChangeNotifierProvider((ref) {
  return SearchProvider();
});
