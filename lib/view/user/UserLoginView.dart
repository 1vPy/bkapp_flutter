//Created by 1vPy on 2019/10/16.
import 'package:bkapp_flutter/entity/user/UserEntity.dart';
import 'package:dio/dio.dart';

class UserLoginView {
  void loginSuccess(UserEntity userEntity) {}

  void loginFail(DioError error) {}
}
