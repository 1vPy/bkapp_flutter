import 'package:flutter/material.dart';
import 'component/home/HomeDrawer.dart';
import 'component/movie/MovieMainPage.dart';
import 'component/shortvideo/ShortVideoPage.dart';

void main() => runApp(MyApp());

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var title = '电影';

  Widget currentPage = MovieMainPage();

  void _selected(id) {
    switch (id) {
      case 0:
        setState(() {
          title = '电影';
          currentPage = MovieMainPage();
        });
        break;
      case 1:
        setState(() {
          title = '短视频';
          currentPage = ShortVideoPage();
        });
        break;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
            builder: (context) => IconButton(
                icon: Image.asset(
                  'images/icon_avatar.png',
                  width: 40,
                  height: 40,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                })),
        title: Text(title),
      ),
      drawer: Drawer(child: HomeDrawer(_selected)),
      body: currentPage,
    );
  }
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
        accentColor: const Color(0xFF64ffda),
        canvasColor: const Color(0xFF303030),
      ),
      home: HomePage(),
    );
  }
}
