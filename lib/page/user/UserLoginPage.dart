import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class UserLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserLoginPageState();
}

class UserLoginPageState extends State<UserLoginPage> {
  String _username;
  String _password;

  void onUserLogin() {

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  size: 13,
                ),
                hintText: '用户名'),
            onSaved: (value) {
              _username = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  size: 13,
                ),
                hintText: '密码'),
            obscureText: true,
            onSaved: (value) {
              _password = value;
            },
          ),
          RaisedButton(
            child: Text('登录'),
            onPressed: this.onUserLogin,
          )
        ],
      ),
    );
  }
}
