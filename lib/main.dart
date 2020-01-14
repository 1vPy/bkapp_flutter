import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/component/list_helper.dart';
import 'package:bkapp_flutter/component/home/home_drawer.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/page/feedback_page.dart';
import 'package:bkapp_flutter/page/movie/movie_main_page.dart';
import 'package:bkapp_flutter/page/movie/search_page.dart';
import 'package:bkapp_flutter/page/setting/system_setting_page.dart';
import 'package:bkapp_flutter/page/shortvideo/short_video_page.dart';
import 'package:bkapp_flutter/page/tv/tv_main_page.dart';
import 'package:bkapp_flutter/page/tv/tv_rank_page.dart';
import 'package:bkapp_flutter/utils/db_util.dart';
import 'package:bkapp_flutter/utils/storage_util.dart';
import 'package:bkapp_flutter/utils/theme_util.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
//  print(await StorageUtil.instance.getBool('isDarkTheme'));
//  Constants.isDarkTheme =
//      await StorageUtil.instance.getBool('isDarkTheme') ?? true;
  return runApp(MyApp());
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends BaseState<HomePage> {
  DateTime _lastPressedAt;

  var title = '电视';
  PageController _pageController = PageController(initialPage: 0);

  Widget _tvPage = TvMainPage();
  Widget _moviePage = MovieMainPage();
  Widget _shortVideoPage = ShortVideoPage();

  @override
  void initState() {
    super.initState();
    DBUtil().initDb();
  }

  void _selected(id) {
    Navigator.pop(context);
    switch (id) {
      case 0:
        setState(() {
          title = '电视';
        });
        _pageController.jumpToPage(id);
        break;
      case 1:
        setState(() {
          title = '电影';
        });
        _pageController.jumpToPage(id);
        break;
      case 2:
        setState(() {
          title = '短视频';
        });
        _pageController.jumpToPage(id);
        break;
      case 4:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SystemSettingPage()));
        break;
      case 5:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FeedbackPage()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          title == '电影' || title == '短视频' || title == '电视'
              ? IconButton(
                  icon: Icon(Icons.search, size: 30),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SearchPage()));
                  },
                )
              : Container(),
        ],
      ),
      drawer: Drawer(child: HomeDrawer(this._selected)),
      body: Builder(builder: (context) {
        return WillPopScope(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _tvPage,
                _moviePage,
                _shortVideoPage,
              ],
              controller: _pageController,
            ),
            onWillPop: () async {
              if (Scaffold.of(context).isDrawerOpen) {
                return true;
              }
              if (_lastPressedAt == null ||
                  DateTime.now().difference(_lastPressedAt) >
                      Duration(seconds: 2)) {
                _lastPressedAt = DateTime.now();
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(
                    '再次点击退出程序',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                ));
                return false; // 不退出
              }
              return true; //退出
            });
      }),
    );
  }

  void toSearchPage() {}
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends BaseState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
        hideFooterWhenNotFull: true,
        maxOverScrollExtent: 0,
        headerTriggerDistance: 35,
        footerTriggerDistance: 35,
        headerBuilder: ListHelper.createHeader,
        footerBuilder: ListHelper.createFooter,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              brightness: isDark ? Brightness.dark : Brightness.light,
              primarySwatch: Colors.blue,
              primaryColor: Colors.blue,
              accentColor: Colors.blue,
              canvasColor: isDark
                  ? ThemeUtil.instance.darkTheme['canvasColor']
                  : ThemeUtil.instance.lightTheme['canvasColor'],
              pageTransitionsTheme: PageTransitionsTheme(builders: {
                TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
              })),
          home: HomePage(),
        ));
  }
}
