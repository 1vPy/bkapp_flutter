//Created by 1vPy on 2019/10/24.
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/event/app_theme_change_event.dart';
import 'package:bkapp_flutter/utils/event_bus_util.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  int isDark = Constants.isDarkTheme;

  @override
  void initState() {
    super.initState();
    registerEvent();
  }

  void registerEvent() {
    EventBusUtil.instance.eventBus.on<AppThemeChangeEvent>().listen((event) {
      setState(() {
        isDark = Constants.isDarkTheme;
      });
    });
  }

  @override
  void setState(fn) {
    if(mounted){
      super.setState(fn);
    }
  }
}
