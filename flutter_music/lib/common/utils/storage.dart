import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地存储
/// 单例 StorageUtil().getItem('key')
class StorageUtil {
  static final StorageUtil _singleton = new StorageUtil._internal();
  factory StorageUtil() => _singleton;

  SharedPreferences get prefs => _prefs;
  static late SharedPreferences _prefs;

  StorageUtil._internal() {
    init();
  }

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// 设置 json 对象
  Future<bool> setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return prefs.setString(key, jsonString);
  }

  /// 获取 json 对象
  dynamic getJSON(String key) {
    String? jsonString = prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  /// 删除 json 对象
  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }
}
