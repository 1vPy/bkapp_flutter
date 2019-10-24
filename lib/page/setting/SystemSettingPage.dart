//Created by 1vPy on 2019/10/24.
import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/event/AppThemeChangeEvent.dart';
import 'package:bkapp_flutter/page/BaseState.dart';
import 'package:bkapp_flutter/utils/EventBusUtil.dart';
import 'package:bkapp_flutter/utils/StorageUtil.dart';
import 'package:bkapp_flutter/utils/ThemeUtil.dart';
import 'package:flutter/material.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemSettingPageState();
  }
}

class SystemSettingPageState extends BaseState<SystemSettingPage> {
  bool isDarkTheme = Constants.isDarkTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('系统设置'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
              title: Text(
                '深色主题',
              ),
              trailing: Switch(
                  value: isDarkTheme,
                  onChanged: (value) {
                    Constants.isDarkTheme = value;
                    StorageUtil.instance.saveBool('isDarkTheme', value);
                    setState(() {
                      isDarkTheme = value;
                    });
                    EventBusUtil.instance.eventBus.fire(AppThemeChangeEvent());
                  })),
          Container(
            width: 200,
            height: 1,
            color: isDark
                ? ThemeUtil.instance.darkTheme['separator']
                : ThemeUtil.instance.lightTheme['separator'],
          )
        ],
      ),
    );
  }
}
