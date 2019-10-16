import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class SnackBarUtil {
  static SnackBarUtil _instance;

  static SnackBarUtil getInstance(BuildContext context) =>
      _getInstance(context);
  ScaffoldState _scaffoldState;

  SnackBarUtil._internal(BuildContext context) {
    _scaffoldState = Scaffold.of(context);
  }

  static SnackBarUtil _getInstance(BuildContext context) {
    if (_instance == null) {
      _instance = new SnackBarUtil._internal(context);
    }
    return _instance;
  }

  void showSnackBar(SnackBarStatus status, String tips,
      {bool needAction = false, String actionName, VoidCallback onPress}) {
    if (needAction) {
      _scaffoldState.showSnackBar(new SnackBar(
        content: Row(children: <Widget>[
          Icon(getIcon(status)),
          Container(margin: EdgeInsets.only(left: 10), child: Text(tips))
        ]),
        action: SnackBarAction(label: actionName, onPressed: onPress),
      ));
    } else {
      _scaffoldState.showSnackBar(new SnackBar(
          content: Row(children: <Widget>[
        Icon(getIcon(status)),
        Container(margin: EdgeInsets.only(left: 10), child: Text(tips))
      ])));
    }
  }

  IconData getIcon(SnackBarStatus status) {
    switch (status) {
      case SnackBarStatus.error:
        return Icons.error;
      case SnackBarStatus.success:
        return Icons.done;
      case SnackBarStatus.loading:
        return Icons.refresh;
      case SnackBarStatus.fail:
        return Icons.autorenew;
      case SnackBarStatus.warming:
        return Icons.warning;
      default:
        return null;
    }
  }
}

enum SnackBarStatus {
  error,
  success,
  loading,
  fail,
  warming,
}
