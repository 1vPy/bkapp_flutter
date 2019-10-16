import 'dart:math';

import 'package:bkapp_flutter/entity/shortvideo/ShortVideoList.dart';
import 'package:bkapp_flutter/presenter/shotvideo/ShortVideoPresenter.dart';
import 'package:bkapp_flutter/presenter/shotvideo/impl/ShortVideoPresenterImpl.dart';
import 'package:bkapp_flutter/view/shortvideo/ShortVideoView.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:video_player/video_player.dart';
import 'package:bkapp_flutter/entity/shortvideo/item_list.dart';

class ShortVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ShortVideoPageState();
}

class ShortVideoPageState extends State<ShortVideoPage>
    with ShortVideoView, AutomaticKeepAliveClientMixin {
  // VideoPlayerController _videoPlayerController = VideoPlayerController.network(
  //     'http://baobab.kaiyanapp.com/api/v1/playUrl?vid=104625&resourceType=video&editionType=default&source=aliyun');
  ShortVideoPresenter _shortVideoPresenter;
  RefreshController _refreshController;
  List<ItemList> _items = [];
  int _currentStart = 1;
  bool _isRefreshing = false;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _shortVideoPresenter = ShortVideoPresenterImpl(this);
    _shortVideoPresenter.getShortVideo(_currentStart, 10);
  }

  Widget buildItem(context, index) {
    return Center(
      // child: _videoPlayerController.value.initialized
      //     ? AspectRatio(
      //         aspectRatio: 16.0 / 9.0,
      //         child: VideoPlayer(_videoPlayerController),
      //       )
      //     : Container(),
      child: Image.network(_items[index].data.cover.feed),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: this.buildItem,
        onPageChanged: this.onPageChanged,
        itemCount: _items.length,
      );
  }

  void onPageChanged(index) {
    if (index == _items.length - 1) {
      _shortVideoPresenter.getShortVideo(_currentStart + 10, 10);
      _refreshController.requestRefresh(needMove: false);
      setState(() {
        _currentStart = _currentStart + 10;
        _isLoading = true;
      });
    }
  }

  void onRefresh() {
    _shortVideoPresenter.getShortVideo(1, 10);
    setState(() {
      _currentStart = 1;
      _isRefreshing = true;
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void requestShortVideoFail(DioError error) {}

  @override
  void requestShortVideoSuccess(ShortVideoList shortVideoList) {
    if (_isRefreshing) {
      setState(() {
        _items = shortVideoList.itemList;
      });
      setState(() {
        _isRefreshing = false;
      });
    } else if (_isLoading) {
      var its = _items;
      its.addAll(shortVideoList.itemList);
      setState(() {
        _items = its;
        _isLoading = false;
      });
      _refreshController.refreshCompleted();
    } else {
      setState(() {
        _items = shortVideoList.itemList;
      });
    }
  }
}
