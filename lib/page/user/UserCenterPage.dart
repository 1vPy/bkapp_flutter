import 'package:bkapp_flutter/page/BaseState.dart';
import 'package:bkapp_flutter/page/user/UserLoginPage.dart';
import 'package:bkapp_flutter/utils/StorageUtil.dart';
import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class UserCenterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserCenterPageState();
}

class UserCenterPageState extends BaseState<UserCenterPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('用户中心'),
      ),
      body: ListView(
        children: <Widget>[
          MaterialButton(
            onPressed: () {
              showExitDialog();
            },
            child: Text('退出登录'),
          )
        ],
      ),
    );
  }

  void showExitDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('确定退出'),
            content: Text('确定要退出登录吗？'),
            actions: <Widget>[
              MaterialButton(
                onPressed: () {
                  StorageUtil.instance.clearUserInfo();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => UserLoginPage()));
                },
                child: Text('确定'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('取消'),
              )
            ],
          );
        });
  }
}
