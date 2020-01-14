import 'package:bkapp_flutter/http/bmob_api.dart';
import 'package:bkapp_flutter/presenter/user/user_login_presente.dart';
import 'package:bkapp_flutter/view/user/user_login_view.dart';

//Created by 1vPy on 2019/10/16.
class UserLoginPresenterImpl implements UserLoginPresenter {
  UserLoginView view;

  UserLoginPresenterImpl(this.view);

  @override
  void login(String username, String password) {
    BmobApi.instance.pwdLogin(username, password).listen((response) {
      view.loginSuccess(response);
    }, onError: (error) {
      view.loginFail(error);
    });
  }
}
