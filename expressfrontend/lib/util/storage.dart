import 'package:localstorage/localstorage.dart';

class Storage {
  static final LocalStorage storage = new LocalStorage("weather");

  Storage();

  static dynamic getValue(String key) {
    return storage.getItem(key);
  }

  static setValue(String key, dynamic value) {
    storage.setItem(key, value);
  }

  static clearStorage() async {
    await storage.clear();
  }
}
