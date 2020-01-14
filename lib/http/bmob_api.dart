//Created by 1vPy on 2019/10/16.
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/entity/user/user_entity.dart';
import 'package:bkapp_flutter/utils/http_util.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class BmobApi {
  static final BmobApi instance = BmobApi.internal();

  BmobApi.internal();

  PublishSubject<UserEntity> pwdLogin(String username, String password) {
    PublishSubject<UserEntity> _subject = PublishSubject();
    HttpUtil.getInstance(baseUrl: Constants.BmobApiUrl)
        .get('1/login',
            param: {'username': username, 'password': password},
            options: Options(headers: {
              'X-Bmob-Application-Id': Constants.BmobAppId,
              'X-Bmob-REST-API-Key': Constants.BmobRestKey,
              'Content-Type': 'application/json'
            }))
        .listen((response) {
      _subject.add(UserEntity.fromJsonMap(response.data));
    }, onError: (error) {
      _subject.addError(error);
    });
    return _subject;
  }
}
