import 'package:bkapp_flutter/entity/user/UserEntity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

//Created by 1vPy on 2019/10/16.
class StorageUtil {
  static final StorageUtil instance = StorageUtil.internal();

  StorageUtil.internal() {}

  void saveBool(String key, bool value) async {
    (await SharedPreferences.getInstance()).setBool(key, value);
  }

  void saveString(String key, String value) async {
    (await SharedPreferences.getInstance()).setString(key, value);
  }

  void saveInt(String key, int value) async {
    (await SharedPreferences.getInstance()).setInt(key, value);
  }

  void saveUserInfo(UserEntity entity) async {
    (await SharedPreferences.getInstance()).setString('userInfo', json.encode(entity));
  }

  Future<UserEntity> getUserInfo() async {
    SharedPreferences _sharedPreferences = await SharedPreferences.getInstance();
    if (_sharedPreferences.getString('userInfo') == null) {
      return null;
    }
    Map map = json.decode(_sharedPreferences.getString('userInfo'));
    return UserEntity.fromJsonMap(map);
  }

  Future<bool> getBool(String key) async {
    return (await SharedPreferences.getInstance()).getBool(key);
  }

  Future<String> getString(String key) async {
    return (await SharedPreferences.getInstance()).getString(key);
  }

  Future<int> getInt(String key) async {
    return (await SharedPreferences.getInstance()).getInt(key);
  }

  void remove(String key) async {
    (await SharedPreferences.getInstance()).remove(key);
  }
}
