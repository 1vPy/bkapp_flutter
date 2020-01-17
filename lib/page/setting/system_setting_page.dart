//Created by 1vPy on 2019/10/24.
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/event/app_theme_change_event.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/utils/event_bus_util.dart';
import 'package:bkapp_flutter/utils/storage_util.dart';
import 'package:bkapp_flutter/utils/theme_util.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SystemSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SystemSettingPageState();
  }
}

class SystemSettingPageState extends BaseState<SystemSettingPage> {
  int isDarkTheme = Constants.isDarkTheme;

  Widget buildSeparator() {
    return Container(
      width: 200,
      height: 1,
    );
  }

  Widget buildModeSwitchItem() {
    return ListTile(
      title: Text(
        '深色主题',
      ),
      trailing: Text(
          Constants.isDarkTheme == Constants.themeMode[ThemeType.FOLLOW_SYSTEM]
              ? '跟随系统'
              : Constants.isDarkTheme == Constants.themeMode[ThemeType.DARK]
                  ? '开'
                  : '关'),
      onTap: () {
        showModeSwitcher(context);
      },
    );
  }

  Widget buildPlayModeSwitchItem() {
    return ListTile(
      title: Text(
        '播放模式',
      ),
      trailing: Text(Constants.playInMobile ? 'wifi 和 移动网络' : '仅wifi'),
      onTap: () {
        showPlayModeSwitcher();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('系统设置'),
      ),
      body: ListView(
        children: <Widget>[
          buildModeSwitchItem(),
          buildSeparator(),
          buildPlayModeSwitchItem(),
          buildSeparator(),
        ],
      ),
    );
  }

  void showPlayModeSwitcher() {
    showModalBottomSheet(
        builder: (BuildContext context) {
          return ListView(
            children: <Widget>[
              ListTile(
                title: Text('wifi 和 移动网络'),
                onTap: () {
                  Constants.playInMobile = true;
                  StorageUtil.instance.saveBool('playInMobile', true);
                  setState((){});
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('仅wifi'),
                onTap: () async {
                  Constants.playInMobile = false;
                  StorageUtil.instance.saveBool('playInMobile', false);
                  setState((){});
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
        context: context);
  }

  void showModeSwitcher(parentContext) {
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
                  EventBusUtil.instance.eventBus.fire(AppThemeChangeEvent());
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('开'),
                onTap: () async {
                  Navigator.of(context).pop();

                  if (Constants.isDarkTheme !=
                      Constants.themeMode[ThemeType.DARK]) {
                    Constants.isDarkTheme = Constants.themeMode[ThemeType.DARK];
                    StorageUtil.instance.saveInt(
                        'isDarkTheme', Constants.themeMode[ThemeType.DARK]);
                    await showSwitchAnim(true, parentContext);

                    EventBusUtil.instance.eventBus.fire(AppThemeChangeEvent());
                  }
                },
              ),
              ListTile(
                title: Text('关'),
                onTap: () async {
                  Navigator.of(context).pop();

                  if (Constants.isDarkTheme !=
                      Constants.themeMode[ThemeType.LIGHT]) {
                    Constants.isDarkTheme =
                        Constants.themeMode[ThemeType.LIGHT];
                    StorageUtil.instance.saveInt(
                        'isDarkTheme', Constants.themeMode[ThemeType.LIGHT]);
                    await showSwitchAnim(false, parentContext);

                    EventBusUtil.instance.eventBus.fire(AppThemeChangeEvent());
                  }
                },
              ),
            ],
          );
        },
        context: context);
  }

  Future showSwitchAnim(bool toDark, parentContext) {
    return Navigator.push(parentContext, PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
      return FadeTransition(
          opacity: animation,
          child: Container(
            child: FlareActor(
              'assets/ModeSwitcher.flr',
              fit: BoxFit.fitHeight,
              animation: toDark ? 'Dark to light' : 'Light to dark',
              callback: (name) {
                Navigator.of(context).pop();
              },
            ),
          ));
    }));
  }
}
