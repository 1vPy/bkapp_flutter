import 'package:shared_preferences/shared_preferences.dart';

//Created by 1vPy on 2019/10/16.
class StorageUtil {
  static final StorageUtil _instance = StorageUtil.internal();
  SharedPreferences _sharedPreferences;

  StorageUtil.internal() {
    initSharePreference();
  }

  void initSharePreference() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void saveBool(String key, bool value) {
    _sharedPreferences.setBool(key, value);
  }

  void saveString(String key, String value) {
    _sharedPreferences.setString(key, value);
  }

  void saveInt(String key, int value) {
    _sharedPreferences.setInt(key, value);
  }

  bool getBool(String key){
    return _sharedPreferences.getBool(key);
  }

  String getString(String key){
    return _sharedPreferences.getString(key);
  }

  int getInt(String key){
    return _sharedPreferences.getInt(key);
  }
}
