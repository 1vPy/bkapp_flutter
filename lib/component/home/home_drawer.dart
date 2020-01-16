import 'package:bkapp_flutter/entity/user/user_entity.dart';
import 'package:bkapp_flutter/event/user_login_status_change_event.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/page/user/user_center_page.dart';
import 'package:bkapp_flutter/page/user/user_login_page.dart';
import 'package:bkapp_flutter/utils/event_bus_util.dart';
import 'package:bkapp_flutter/utils/storage_util.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class HomeDrawer extends StatefulWidget {
  final Function _onSelected;

  const HomeDrawer(this._onSelected) : super();

  @override
  State<StatefulWidget> createState() => HomeDrawerState();
}

class HomeDrawerState extends BaseState<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        HeaderDrawer(),
        ListTile(title: Text('分类')),
        ItemDrawer(0, '电视', Icon(Icons.tv), widget._onSelected),
        ItemDrawer(1, '电影', Icon(Icons.movie), widget._onSelected),
        ItemDrawer(2, '短视频', Icon(Icons.music_video), widget._onSelected),
        Divider(
          color: Colors.grey,
          height: 1.0,
        ),
        ListTile(title: Text('选项')),
        ItemDrawer(3, '我的收藏', Icon(Icons.collections_bookmark), widget._onSelected),
        ItemDrawer(4, '系统设置', Icon(Icons.settings), widget._onSelected),
        ItemDrawer(5, '问题反馈', Icon(Icons.message), widget._onSelected),
        ItemDrawer(6, '关于', Icon(Icons.info), widget._onSelected),
      ],
    );
  }
}

class ItemDrawer extends StatefulWidget {
  final id;
  final title;
  final icon;
  final _onSelected;

  ItemDrawer(this.id, this.title, this.icon, this._onSelected) : super();

  @override
  State<StatefulWidget> createState() =>
      ItemDrawerState();
}

class ItemDrawerState extends BaseState<ItemDrawer> {
  var selected = false;

  ItemDrawerState() : super();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.icon,
      title: Text(widget.title),
      selected: selected,
      onTap: () {
        widget._onSelected(widget.id);
      },
    );
  }
}

class HeaderDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HeaderDrawerState();
}

class HeaderDrawerState extends BaseState<HeaderDrawer> {
  UserEntity _userEntity;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void registerEvent() {
    EventBusUtil.instance.eventBus
        .on<UserLoginStatusChangeEvent>()
        .listen((event) {
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
