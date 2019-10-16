import 'package:bkapp_flutter/entity/enum/LoginStatus.dart';
import 'package:bkapp_flutter/entity/user/UserEntity.dart';
import 'package:bkapp_flutter/event/UserLoginStatusChangeEvent.dart';
import 'package:bkapp_flutter/page/user/UserCenterPage.dart';
import 'package:bkapp_flutter/presenter/user/UserLoginPresente.dart';
import 'package:bkapp_flutter/presenter/user/impl/UserLoginPresenterImpl.dart';
import 'package:bkapp_flutter/utils/SnackBarUtil.dart';
import 'package:bkapp_flutter/utils/StorageUtil.dart';
import 'package:bkapp_flutter/view/user/UserLoginView.dart';
import 'package:dio/src/dio_error.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class UserLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserLoginPageState();
}

class UserLoginPageState extends State<UserLoginPage> implements UserLoginView {
  String _username;
  String _password;
  UserLoginPresenter _loginPresenter;
  BuildContext _buildContext;

  @override
  void initState() {
    super.initState();
    _loginPresenter = new UserLoginPresenterImpl(this);
  }

  void onUserLogin() {
    _loginPresenter.login(_username, _password);
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('用户登录'),
      ),
      body: Form(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    labelText: '用户名',
                    border: OutlineInputBorder()),
                onChanged: (value) {
                  _username = value;
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 30,
                      ),
                      labelText: '密码',
                      border: OutlineInputBorder()),
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                ),
              ),
              RaisedButton(
                child: Text('登录'),
                onPressed: this.onUserLogin,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void loginFail(DioError error) {
//      SnackBarUtil.getInstance(_buildContext).showSnackBar(SnackBarStatus.fail, '登录失败: ${error.message}');
  }

  @override
  void loginSuccess(UserEntity userEntity) {
    StorageUtil.instance.saveUserInfo(userEntity);
    EventBus().fire(UserLoginStatusChangeEvent(LoginStatus.Login));
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => UserCenterPage()));
  }
}
