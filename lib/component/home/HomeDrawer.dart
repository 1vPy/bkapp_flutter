import 'package:bkapp_flutter/page/movie/MovieMainPage.dart';
import 'package:bkapp_flutter/page/user/UserCenterPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeDrawer extends StatefulWidget {
  final ValueChanged<int> selected;

  const HomeDrawer(this.selected) : super();

  @override
  State<StatefulWidget> createState() => HomeDrawerState(selected);
}

class HomeDrawerState extends State<HomeDrawer> {
  final ValueChanged<int> selected;

  HomeDrawerState(this.selected);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HeaderDrawer(),
        ListTile(title: Text('分类')),
        ItemDrawer(0, '电影', 'images/icon_movie.png', selected),
        ItemDrawer(1, '短视频', 'images/icon_music.png', selected),
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
        ListTile(title: Text('选项')),
        ItemDrawer(2, '我的收藏', 'images/icon_collection.png', selected),
        ItemDrawer(3, '系统设置', 'images/icon_setting.png', selected),
        ItemDrawer(4, '问题反馈', 'images/icon_feedback.png', selected),
        ItemDrawer(5, '关于', 'images/icon_about.png', selected),
      ],
    );
  }
}

class ItemDrawer extends StatefulWidget {
  final id;
  final title;
  final icon;
  final onSelected;

  ItemDrawer(this.id, this.title, this.icon, this.onSelected) : super();

  @override
  State<StatefulWidget> createState() =>
      ItemDrawerState(id, title, icon, onSelected);
}

class ItemDrawerState extends State<ItemDrawer> {
  var id = 0;
  var title = '';
  var icon = '';
  var selected = false;
  ValueChanged<int> onSelected;

  ItemDrawerState(this.id, this.title, this.icon, this.onSelected) : super();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        icon,
        width: 25,
        height: 25,
      ),
      title: Text(title),
      selected: selected,
      onTap: () {
        onSelected(id);
      },
    );
  }
}

class HeaderDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderDrawerState();
}

class HeaderDrawerState extends State<HeaderDrawer> {
  var accountName = '';
  var accountEmail = '';
  var accountAvatar = '';

  @override
  void initState() {
    super.initState();
  }

  void getUserInfo() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    accountName = _sharedPreferences.getString('accountName');
    accountEmail = _sharedPreferences.getString('accountEmail');
    accountAvatar = _sharedPreferences.getString('accountAvatar');
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        padding: EdgeInsets.all(0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(decoration: BoxDecoration(color: Colors.black12)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: FittedBox(),
                  flex: 1,
                ),
                Expanded(
                  child: FittedBox(
                      alignment: AlignmentDirectional.center,
                      child: GestureDetector(
                        child: CircleAvatar(
                            child: accountAvatar.isEmpty
                                ? Image.asset(
                                    'images/icon_avatar.png',
                                  )
                                : Image.network(
                                    accountAvatar,
                                  )),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserCenterPage()));
                        },
                      )),
                  flex: 2,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: GestureDetector(
                      child: Text(accountName.isEmpty ? '点击登录' : accountName,
                          style: TextStyle(fontSize: 13)),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UserCenterPage()));
                      }),
                )
              ],
            )
          ],
        ));
  }
}
