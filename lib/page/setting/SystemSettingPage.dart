//Created by 1vPy on 2019/10/24.
import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/event/AppThemeChangeEvent.dart';
import 'package:bkapp_flutter/page/BaseState.dart';
import 'package:bkapp_flutter/utils/EventBusUtil.dart';
import 'package:bkapp_flutter/utils/StorageUtil.dart';
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
    return Container(
      child: Switch(
          value: isDarkTheme,
          onChanged: (value) {
            Constants.isDarkTheme = value;
            StorageUtil.instance.saveBool('isDarkTheme', value);
            setState(() {
              isDarkTheme = value;
            });
            EventBusUtil.instance.eventBus.fire(AppThemeChangeEvent());
          }),
      alignment: Alignment.center,
    );
  }
}
