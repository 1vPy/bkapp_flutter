import 'package:bkapp_flutter/component/list_helper.dart';
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/event/app_theme_change_event.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/page/home_page.dart';
import 'package:bkapp_flutter/page/splash_page.dart';
import 'package:bkapp_flutter/utils/db_util.dart';
import 'package:bkapp_flutter/utils/event_bus_util.dart';
import 'package:bkapp_flutter/utils/storage_util.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends BaseState<MyApp> {
  @override
  void initState() {
    super.initState();
    DBUtil().initDb();
    setMode();
  }

  void setMode() async {
    print(await StorageUtil.instance.getInt('isDarkTheme'));
    Constants.isDarkTheme = await StorageUtil.instance.getInt('isDarkTheme') ??
        Constants.themeMode[ThemeType.FOLLOW_SYSTEM];
    EventBusUtil.instance.eventBus.fire(AppThemeChangeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        hideFooterWhenNotFull: true,
        maxOverScrollExtent: 0,
        headerTriggerDistance: 35,
        footerTriggerDistance: 35,
        headerBuilder: ListHelper.createHeader,
        footerBuilder: ListHelper.createFooter,
        child: isDark == Constants.themeMode[ThemeType.FOLLOW_SYSTEM]
            ? MaterialApp(
                routes: {
                  '/homePage': (context) => HomePage(),
                },
                title: 'Flutter Demo',
                darkTheme: ThemeData.dark(),
                theme: ThemeData.light(),
                home: SplashPage(),
              )
            : MaterialApp(
                routes: {
                  '/homePage': (context) => HomePage(),
                },
                title: 'Flutter Demo',
                theme: isDark == Constants.themeMode[ThemeType.DARK]
                    ? ThemeData.dark()
                    : ThemeData.light(),
                home: SplashPage(),
              ));
  }
}
