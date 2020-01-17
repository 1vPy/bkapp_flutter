import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/entity/shortvideo/short_video_list.dart';
import 'package:bkapp_flutter/entity/shortvideo/item_list.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/presenter/shotvideo/short_video_presenter.dart';
import 'package:bkapp_flutter/presenter/shotvideo/impl/short_video_presenter_impl.dart';
import 'package:bkapp_flutter/utils/storage_util.dart';
import 'package:bkapp_flutter/view/shortvideo/short_video_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

//Created by 1vPy on 2019/10/16.
class ShortVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShortVideoPageState();
}

class ShortVideoPageState extends BaseState<ShortVideoPage>
    with ShortVideoView, AutomaticKeepAliveClientMixin {
  ShortVideoPresenter _shortVideoPresenter;
  List<ItemList> _items = [];
  int _currentStart = 1;

  @override
  void initState() {
    super.initState();
    _shortVideoPresenter = ShortVideoPresenterImpl(this);
    this.onRefresh();
  }

  Widget buildItem(context, index) {
    return ShortVideoItem(_items[index]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      backgroundColor: Colors.white,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: this.buildItem,
        itemCount: _items.length,
        onPageChanged: _onPageChange,
      ),
      onRefresh: this.onRefresh,
    );
  }

  void _onPageChange(index) {
    if (index == _items.length - 1) {
      onLoading();
    }
  }

  Future<void> onRefresh() async {
    try {
      Response<Map> response = await _shortVideoPresenter.getShortVideo(1, 10);
      _currentStart = 1;
      setState(() {
        _items = ShortVideoList.fromJsonMap(response.data).itemList;
      });
    } catch (e) {
      print('error = ${e.message}');
    }
  }

  void onLoading() async {
    try {
      Response<Map> response =
          await _shortVideoPresenter.getShortVideo(_currentStart + 10, 10);
      _currentStart = _currentStart + 10;
      var its = _items;
      its.addAll(ShortVideoList.fromJsonMap(response.data).itemList);
      setState(() {
        _items = its;
      });
    } catch (e) {
      print('error = ${e.message}');
    }
  }

  @override
  bool get wantKeepAlive => false;

  @override
  void requestShortVideoFail(DioError error) {}

  @override
  void requestShortVideoSuccess(ShortVideoList shortVideoList) {}
}

class ShortVideoItem extends StatefulWidget {
  final ItemList _item;

  ShortVideoItem(this._item);

  @override
  State<StatefulWidget> createState() => ShortVideoItemState();
}

class ShortVideoItemState extends BaseState<ShortVideoItem> {
  VideoPlayerController _videoPlayerController;
  bool isPlaying = false;
  bool isFavorite = false;
  bool cbMobilePlay = false;
  bool isShowDialog = false;
  ConnectivityResult currentConnection = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget._item.data.playUrl);
    checkNetwork();
  }

  void checkNetwork() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      if (currentConnection != ConnectivityResult.wifi &&
          event == ConnectivityResult.wifi &&
          !_videoPlayerController.value.initialized) {
        currentConnection = ConnectivityResult.wifi;
        if (isShowDialog) {
          isShowDialog = false;
          Navigator.of(context).pop();
        }
        playVideo();
      }
    });
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (!Constants.playInMobile) {
        showAskDialog();
      } else {
        playVideo();
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      playVideo();
    }
  }

  void playVideo() {
    _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      setState(() {
        isPlaying = true;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          _videoPlayerController.value.initialized
              ? Center(
                  child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ))
              : Center(
                  child: CachedNetworkImage(
                    imageUrl: widget._item.data.cover.feed,
                  ),
                ),
          Center(
            child: isPlaying
                ? null
                : Icon(
                    Icons.play_circle_filled,
                    size: 80,
                    color: Colors.white70,
                  ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(10),
            child: Column(
              verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: IconButton(
                      icon: Icon(
                        Icons.share,
                        size: 30,
//                        color: isDark ? Colors.white70 : Colors.grey,
                      ),
                      onPressed: this.showSharePanel),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: IconButton(
                      icon: Icon(
                        Icons.insert_comment,
                        size: 30,
//                        color: isDark ? Colors.white70 : Colors.grey,
                      ),
                      onPressed: this.showCommentPanel),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color: isFavorite ? Colors.red : Colors.white70,
                      ),
                      onPressed: this.setFavorite),
                ),
              ],
            ),
          )
        ],
      ),
      onTap: () {
        if (!_videoPlayerController.value.initialized) {
          return;
        }
        if (_videoPlayerController.value.isPlaying) {
          _videoPlayerController.pause();
          setState(() {
            isPlaying = false;
          });
        } else {
          _videoPlayerController.play();
          setState(() {
            isPlaying = true;
          });
        }
      },
    );
  }

  void showAskDialog() {
    isShowDialog = true;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('当前为移动网络是否进行播放？'),
            actions: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  StatefulBuilder(builder: (context, StateSetter setState) {
                    return Checkbox(
                      value: this.cbMobilePlay,
                      onChanged: (value) {
                        setState(() {
                          if (mounted) {
                            this.cbMobilePlay = value;
                          }
                        });
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }),
                  Text('不再提醒'),
                ],
              ),
              MaterialButton(
                onPressed: () {
                  playVideo();
                  if (cbMobilePlay) {
                    StorageUtil.instance.saveBool('playInMobile', true);
                  }
                  Constants.playInMobile = true;
                  isShowDialog = false;
                  Navigator.of(context).pop();
                },
                child: Text('确定'),
              ),
              MaterialButton(
                onPressed: () {
                  isShowDialog = false;
                  Navigator.of(context).pop();
                },
                child: Text('取消'),
              )
            ],
          );
        });
  }

  void showSharePanel() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 2, right: 2, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              /*color: isDark ? Color(0xFF303030) : Colors.white*/
            ),
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Icon(
                      Icons.cast,
                      size: 30,
                    )),
                    Container(
                      height: 20,
                      child: Text('QQ'),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Icon(
                      Icons.alternate_email,
                      size: 30,
                    )),
                    Container(
                      height: 20,
                      child: Text('微信'),
                    )
                  ],
                )),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Icon(
                      Icons.devices_other,
                      size: 30,
                    )),
                    Container(
                      height: 20,
                      child: Text('微博'),
                    )
                  ],
                )),
              ],
            ),
          );
        });
  }

  void showCommentPanel() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            margin: EdgeInsets.only(left: 2, right: 2, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              /*color: isDark ? Color(0xFF303030) : Colors.white*/
            ),
            height: MediaQuery.of(context).size.height * 0.52,
            child: Column(
              children: <Widget>[],
            ),
          );
        });
  }

  void setFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('=================================================== dispose');
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
  }
}
