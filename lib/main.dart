import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/component/home/HomeDrawer.dart';
import 'package:bkapp_flutter/page/BaseState.dart';
import 'package:bkapp_flutter/page/movie/MovieMainPage.dart';
import 'package:bkapp_flutter/page/movie/SearchPage.dart';
import 'package:bkapp_flutter/page/setting/SystemSettingPage.dart';
import 'package:bkapp_flutter/page/shortvideo/ShortVideoPage.dart';
import 'package:bkapp_flutter/utils/DBUtil.dart';
import 'package:bkapp_flutter/utils/StorageUtil.dart';
import 'package:bkapp_flutter/utils/ThemeUtil.dart';
import 'package:flutter/material.dart';

void main() async {
  print(await StorageUtil.instance.getBool('isDarkTheme'));
  Constants.isDarkTheme =
      await StorageUtil.instance.getBool('isDarkTheme') ?? true;
  return runApp(MyApp());
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var title = '电影';
  PageController _pageController = PageController(initialPage: 0);

  Widget _moviePage = MovieMainPage();
  Widget _shortVideoPage = ShortVideoPage();
  Widget _systemSettingPage = SystemSettingPage();

  @override
  void initState() {
    super.initState();
    DBUtil().initDb();
  }

  void _selected(id) {
    switch (id) {
      case 0:
        setState(() {
          title = '电影';
        });
        break;
      case 1:
        setState(() {
          title = '短视频';
        });
        break;
      case 3:
        setState(() {
          title = '系统设置';
        });
        break;
    }
    _pageController.jumpToPage(id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, size: 30),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(child: HomeDrawer(_selected)),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          _moviePage,
          _shortVideoPage,
          _systemSettingPage,
          _systemSettingPage
        ],
        controller: _pageController,
      ),
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          canvasColor: Constants.isDarkTheme
              ? ThemeUtil.instance.darkTheme['canvasColor']
              : ThemeUtil.instance.lightTheme['canvasColor'],
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
          })),
      home: HomePage(),
    );
  }
}
