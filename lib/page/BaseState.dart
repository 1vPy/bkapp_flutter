//Created by 1vPy on 2019/10/24.
import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/event/AppThemeChangeEvent.dart';
import 'package:bkapp_flutter/utils/EventBusUtil.dart';
import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  bool isDark = Constants.isDarkTheme;

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
}
