import 'package:bkapp_flutter/page/movie/MovieNowPlayingPage.dart';
import 'package:bkapp_flutter/page/movie/MovieUpcomingPage.dart';
import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class MovieMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieMainPageState();
}

class MovieMainPageState extends State<MovieMainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  PageController _controller = PageController(initialPage: 0);
  TabController _tabController;

  List<Tab> getItems() {
    List<Tab> list = new List();
    list.add(Tab(
      text: "近期热播",
    ));
    list.add(Tab(
      text: "即将上线",
    ));
    return list;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  void onTabTap(int index) {
    _controller.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  void onPageChange(index) {
    _tabController.animateTo(index, duration: Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF303030),
        title: TabBar(
          tabs: getItems(),
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.blue,
          indicatorWeight: 3,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.lightBlueAccent,
          indicatorPadding: EdgeInsets.only(bottom: -3),
          onTap: (index) {
            onTabTap(index);
          },
        ),
      ),
      body: PageView(
        physics: PageScrollPhysics(parent: BouncingScrollPhysics()),
        children: <Widget>[MovieUpcomingPage(), MovieNowPlayingPage()],
        controller: _controller,
        onPageChanged: (index) {
          onPageChange(index);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
