import 'package:consulta_estados_cidades/constants/tags.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageSharedPreferences {
  SharedPreferences prefs;
  Future _doneFuture;

  Future get initializationDone => _doneFuture;

  LocalStorageSharedPreferences() {
    _doneFuture = _initDB();
  }

  _initDB() async {
    prefs = await SharedPreferences.getInstance();
  }

  // void saveTotalElements(int totalElements) {
  //   prefs.setInt(tagTotalElements, totalElements);
  // }
  //
  // int getTotalElements() {
  //   int totalElements = prefs.get(tagTotalElements);
  //   return totalElements != null ? totalElements : null;
  // }
  //
  // void saveTotalPages(int totalPages) {
  //   prefs.setInt(tagTotalPages, totalPages);
  // }
  //
  // int getTotalPages() {
  //   int totalPages = prefs.get(tagTotalPages);
  //   return totalPages != null ? totalPages : null;
  // }
}
