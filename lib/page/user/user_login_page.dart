import 'package:bkapp_flutter/entity/enum/login_status.dart';
import 'package:bkapp_flutter/entity/user/user_entity.dart';
import 'package:bkapp_flutter/event/user_login_status_change_event.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/page/user/user_center_page.dart';
import 'package:bkapp_flutter/presenter/user/user_login_presente.dart';
import 'package:bkapp_flutter/presenter/user/impl/user_login_presenter_impl.dart';
import 'package:bkapp_flutter/utils/event_bus_util.dart';
import 'package:bkapp_flutter/utils/storage_util.dart';
import 'package:bkapp_flutter/view/user/user_login_view.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Created by 1vPy on 2019/10/16.
class UserLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserLoginPageState();
}

class UserLoginPageState extends BaseState<UserLoginPage>
    implements UserLoginView {
  String _username;
  String _password;
  UserLoginPresenter _loginPresenter;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loginPresenter = new UserLoginPresenterImpl(this);
  }

  @override
  void registerEvent() {}

  void onUserLogin() {
    _loginPresenter.login(_username, _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
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
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue))),
                  obscureText: true,
                  onChanged: (value) {
                    _password = value;
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 40),
                height: 40,
                child: RaisedButton(
                  child: Text('登录'),
                  onPressed: this.onUserLogin,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void loginFail(DioError error) {
    print(error);
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        '登录失败:${error.message}',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }

  @override
  void loginSuccess(UserEntity userEntity) {
    StorageUtil.instance.saveUserInfo(userEntity);
    EventBusUtil.instance.eventBus
        .fire(UserLoginStatusChangeEvent(LoginStatus.Login));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => UserCenterPage()));
    Fluttertoast.showToast(msg: '登录成功',);
  }
}
