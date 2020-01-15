//Created by 1vPy on 2019/10/24.
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/event/app_theme_change_event.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/utils/event_bus_util.dart';
import 'package:bkapp_flutter/utils/storage_util.dart';
import 'package:bkapp_flutter/utils/theme_util.dart';
import 'package:flutter/material.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemSettingPageState();
  }
}

class SystemSettingPageState extends BaseState<SystemSettingPage> {
  int isDarkTheme = Constants.isDarkTheme;

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
            trailing: Text(Constants.isDarkTheme ==
                    Constants.themeMode[ThemeType.FOLLOW_SYSTEM]
                ? '跟随系统'
                : Constants.isDarkTheme == Constants.themeMode[ThemeType.DARK]
                    ? '开'
                    : '关'),
            onTap: () {
              showModalBottomSheet(
                  builder: (BuildContext context) {
                    return ListView(
                      children: <Widget>[
                        ListTile(
                          title: Text('跟随系统'),
                          onTap: () {
                            Constants.isDarkTheme =
                                Constants.themeMode[ThemeType.FOLLOW_SYSTEM];
                            StorageUtil.instance.saveInt('isDarkTheme',
                                Constants.themeMode[ThemeType.FOLLOW_SYSTEM]);
                            EventBusUtil.instance.eventBus
                                .fire(AppThemeChangeEvent());
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text('开'),
                          onTap: () {
                            Constants.isDarkTheme =
                                Constants.themeMode[ThemeType.DARK];
                            StorageUtil.instance.saveInt('isDarkTheme',
                                Constants.themeMode[ThemeType.DARK]);
                            EventBusUtil.instance.eventBus
                                .fire(AppThemeChangeEvent());
                            Navigator.of(context).pop();
                          },
                        ),
                        ListTile(
                          title: Text('关'),
                          onTap: () {
                            Constants.isDarkTheme =
                                Constants.themeMode[ThemeType.LIGHT];
                            StorageUtil.instance.saveInt('isDarkTheme',
                                Constants.themeMode[ThemeType.LIGHT]);
                            EventBusUtil.instance.eventBus
                                .fire(AppThemeChangeEvent());
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                  context: context);
            },
          ),
          Container(
            width: 200,
            height: 1,
/*            color: isDark
                ? ThemeUtil.instance.darkTheme['separator']
                : ThemeUtil.instance.lightTheme['separator'],*/
          )
        ],
      ),
    );
  }
}
