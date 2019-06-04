import 'package:bkapp_flutter/page/movie/MovieUpcomingPage.dart';
import 'package:bkapp_flutter/utils/SnackBarUtil.dart';
import 'package:flutter/material.dart';

class MovieMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieMainPageState();
}

class MovieMainPageState extends State<MovieMainPage> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  PageController _controller = PageController(initialPage: 0);

  List<BottomNavigationBarItem> getItems() {
    List<BottomNavigationBarItem> list = new List();
    list.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.equalizer,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.equalizer,
          color: Colors.blueAccent,
        ),
        title: Text('推荐')));
    list.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.movie,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.movie,
          color: Colors.blueAccent,
        ),
        title: Text('电影')));
    list.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.tv,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.tv,
          color: Colors.blueAccent,
        ),
        title: Text('电视剧')));
    list.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.people,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.people,
          color: Colors.blueAccent,
        ),
        title: Text('影星')));
    list.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.white,
        ),
        activeIcon: Icon(
          Icons.person,
          color: Colors.blueAccent,
        ),
        title: Text('我的')));
    return list;
  }

  @override
  void initState() {
    super.initState();
  }

  void onSelectItem(int index) {
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
    setState(() {
      currentIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            MovieUpcomingPage(),
            MovieUpcomingPage(),
            MovieUpcomingPage(),
            MovieUpcomingPage(),
            MovieUpcomingPage()
          ],
          controller: _controller),
      bottomNavigationBar: BottomNavigationBar(
          items: getItems(),
          currentIndex: currentIndex,
          onTap: onSelectItem,
          backgroundColor: Colors.black54,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          elevation: 5,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.white),
    );
  }
}
