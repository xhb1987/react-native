import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final LocalStorage storage = new LocalStorage("weather");

  static Future<bool> isReady() {
    return storage.ready;
  }

  static isStorageReady() async {
    bool isReady = await storage.ready;
    return isReady;
  }

  static getValue(String key) async {
    var items = await storage.getItem(key);
    return items;
  }

  static setValue(String key, dynamic value) {
    storage.setItem(key, value);
  }

  static deleteItem(String key) {
    storage.deleteItem(key);
  }

  static clearStorage() async {
    await storage.clear();
  }
}
