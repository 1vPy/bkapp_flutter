import 'package:bkapp_flutter/page/movie/SearchPage.dart';
import 'package:bkapp_flutter/page/user/UserCenterPage.dart';
import 'package:flutter/material.dart';
import 'component/home/HomeDrawer.dart';
import 'page/movie/MovieMainPage.dart';
import 'page/shortvideo/ShortVideoPage.dart';

void main() => runApp(MyApp());

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var title = '电影';
  PageController _pageController = PageController(initialPage: 0);

  Widget _moviePage = MovieMainPage();
  Widget _shortVideoPage = ShortVideoPage();

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
                  .push(
                  MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(child: HomeDrawer(_selected)),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[_moviePage, _shortVideoPage],
        controller: _pageController,
      ),
    );
  }

  void toSearchPage() {}
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          accentColor: Colors.blue,
          canvasColor: const Color(0xFF303030),
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
          })),
      home: HomePage(),
    );
  }
}
