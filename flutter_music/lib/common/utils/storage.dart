import 'package:flutter_music/common/values/values.dart';
import 'package:localstorage/localstorage.dart';

/// 本地存储
/// 单例 StorageUtil().getItem('key')
class StorageUtil {
  static final StorageUtil _singleton = new StorageUtil._internal();
  factory StorageUtil() => _singleton;

  LocalStorage get storage => _storage;
  late LocalStorage _storage;

  StorageUtil._internal() {
    _storage = new LocalStorage(STORAGE_MASTER_KEY);
  }

  String getItem(String key) {
    return _storage.getItem(key);
  }

  Future<void> setItem(String key, String val) async {
    await _storage.setItem(key, val);
  }
}
