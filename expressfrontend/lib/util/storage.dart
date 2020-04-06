import 'package:localstorage/localstorage.dart';

class Storage {
  static final LocalStorage storage = new LocalStorage("weather");

  Storage();

  static isStorageReady() async {
    bool isReady = await storage.ready;
    return isReady;
  }

  static getValue(String key) async {
    var isReady = await isStorageReady();
    if (isReady) {
      var items = storage.getItem(key);
      return items;
    }
  }

  static setValue(String key, dynamic value) {
    storage.setItem(key, value);
  }

  static clearStorage() async {
    await storage.clear();
  }
}
