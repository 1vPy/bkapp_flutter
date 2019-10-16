import 'package:flutter/material.dart';

class UserLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserLoginPageState();
}

class UserLoginPageState extends State<UserLoginPage> {
  var _username;
  var _password;


  void onUserLogin () {
      
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(hintText: '用户名'),
            onSaved: (value) {
              _username = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(hintText: '密码'),
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
