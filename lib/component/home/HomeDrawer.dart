import 'package:bkapp_flutter/entity/user/UserEntity.dart';
import 'package:bkapp_flutter/event/UserLoginStatusChangeEvent.dart';
import 'package:bkapp_flutter/page/user/UserCenterPage.dart';
import 'package:bkapp_flutter/page/user/UserLoginPage.dart';
import 'package:bkapp_flutter/utils/StorageUtil.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
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
        ItemDrawer(0, '电影', Icon(Icons.movie), selected),
        ItemDrawer(1, '短视频', Icon(Icons.music_video), selected),
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
        ListTile(title: Text('选项')),
        ItemDrawer(2, '我的收藏', Icon(Icons.collections_bookmark), selected),
        ItemDrawer(3, '系统设置', Icon(Icons.settings), selected),
        ItemDrawer(4, '问题反馈', Icon(Icons.message), selected),
        ItemDrawer(5, '关于', Icon(Icons.info), selected),
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
  var icon;
  var selected = false;
  ValueChanged<int> onSelected;

  ItemDrawerState(this.id, this.title, this.icon, this.onSelected) : super();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
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
  UserEntity _userEntity;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void registerEvent() {
    EventBus().on<UserLoginStatusChangeEvent>().listen((event) {
      getUserInfo();
    });
  }

  void getUserInfo() async {
    UserEntity userEntity = await StorageUtil.instance.getUserInfo();
    if (userEntity == null) {
      return;
    }
    setState(() {
      _userEntity = userEntity;
    });
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
                            child: _userEntity?.userHeader?.url?.isEmpty ?? true
                                ? Icon(
                                    Icons.account_circle,
                                    size: 40,
                                  )
                                : Image.network(
                                    _userEntity?.userHeader?.url ?? '',
                                  )),
                        onTap: this.toUserCenter,
                      )),
                  flex: 2,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 15.0),
                  child: GestureDetector(
                      child: Text(
                          _userEntity?.username?.isEmpty ?? true
                              ? '点击登录'
                              : _userEntity?.username,
                          style: TextStyle(fontSize: 13)),
                      onTap: this.toUserCenter),
                )
              ],
            )
          ],
        ));
  }

  void toUserCenter() {
    Navigator.of(context).pop();
    if (_userEntity == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserLoginPage()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => UserCenterPage()));
    }
  }
}
