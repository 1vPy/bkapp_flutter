//Created by 1vPy on 2019/11/1.
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/component/list_helper.dart';
import 'package:bkapp_flutter/component/tv/tv_list_item.dart';
import 'package:bkapp_flutter/entity/enum/loading_status.dart';
import 'package:bkapp_flutter/entity/tv/tv_list.dart';
import 'package:bkapp_flutter/entity/tv/results.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/presenter/tv/tv_rank_presenter.dart';
import 'package:bkapp_flutter/presenter/tv/impl/tv_rank_presenter_impl.dart';
import 'package:bkapp_flutter/view/tv/tv_rank_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TvRankPage extends StatefulWidget {
  final String title;

  TvRankPage(this.title);

  @override
  State<StatefulWidget> createState() => TvRankPageState();
}

class TvRankPageState extends BaseState<TvRankPage> implements TvRankView {
  TvRankPresenter _tvRankPresenter;
  RefreshController _refreshController;
  List<Results> _items = [];
  int _page = 1;

  LoadingStatus _status = LoadingStatus.Loading;

  @override
  void initState() {
    super.initState();
    _tvRankPresenter = TvRankPresenterImpl(this);
    _refreshController = RefreshController(initialRefresh: true);
  }

  Widget _buildSwiperItem(context, index) {
    return Container(
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
              child: Container(
                  child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: CachedNetworkImage(
              width: 80,
              height: 100,
              placeholder: (context, url) {
                return ClipRRect(
                  child: Image.asset(
                    'images/movie_placeholder_image.png',
                    width: 80,
                    height: 100,
                  ),
                  borderRadius: BorderRadius.circular(2),
                );
              },
              imageUrl:
                  '${Constants.image_prefix}/w200/${_items[index == 0 ? 1 : index == 1 ? 0 : 2].poster_path}',
              fit: BoxFit.cover,
            ),
          ))),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  index == 0
                      ? Icons.filter_2
                      : index == 1 ? Icons.filter_1 : Icons.filter_3,
                  size: 16,
                  color: index == 0
                      ? Colors.redAccent
                      : index == 1 ? Colors.yellow : Colors.green,
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Text(_items[index == 0 ? 1 : index == 1 ? 0 : 2].name),
                )
              ],
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(top: 5, bottom: 5),
    );
  }

  Widget _buildHeader(context, index) {
    return Container(
      margin: EdgeInsets.only(top: 3, bottom: 3),
      height: 150,
      child: Card(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Swiper(
          scrollDirection: Axis.horizontal,
          loop: false,
          index: 1,
          physics: NeverScrollableScrollPhysics(),
          viewportFraction: 0.3,
          scale: 0.6,
          itemCount: 3,
          containerWidth: MediaQuery.of(context).size.width,
          itemBuilder: this._buildSwiperItem,
        ),
      ),
    );
  }

  Widget _buildItem(context, index) {
    if (index == 0) {
      return _buildHeader(context, index);
    } else if (index > 2) {
      return TvListItem(_items[index], _toDetail, 'topRated');
    } else {
      return Container();
    }
  }

  Widget _createList() {
    return SmartRefresher(
      header: MaterialClassicHeader(),
      enablePullUp: true,
      onRefresh: this._onRefresh,
      onLoading: this._onLoading,
      controller: this._refreshController,
      child: ListView.builder(
        itemBuilder: this._buildItem,
        itemCount: _items.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _status == LoadingStatus.Fail
          ? ListHelper.createFail(_onRetry)
          : _status == LoadingStatus.Loading || _items.length > 0
              ? _createList()
              : ListHelper.createEmpty(),
    );
  }

  void _onRefresh() {
    _tvRankPresenter.requestTopRatedTv(1);
  }

  void _onLoading() {
    _tvRankPresenter.requestTopRatedTv(++_page);
  }

  void _onRetry() {
    setState(() {
      _status = LoadingStatus.Loading;
    });
    _refreshController.requestRefresh();
  }

  void _toDetail(Results item) {}

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  @override
  void requestTvTopRatedFail(DioError error) {
    if (_refreshController.isRefresh) {
      if (_items.length <= 0) {
        setState(() {
          _status = LoadingStatus.Fail;
        });
      }
      _refreshController.refreshFailed();
    } else if (_refreshController.isLoading) {
      _refreshController.loadFailed();
    }
  }

  @override
  void requestTvTopRatedSuccess(TvList tvList) {
    if (_refreshController.isRefresh) {
      setState(() {
        _status = LoadingStatus.Success;
        _items = tvList.results;
      });
      _refreshController.refreshCompleted();
    } else if (_refreshController.isLoading) {
      var its = _items;
      its.addAll(tvList.results);
      setState(() {
        _items = its;
      });
      _refreshController.loadComplete();
    }
    _page = tvList.page;
    if (tvList.page >= tvList.total_pages) {
      _refreshController.loadNoData();
    }
  }
}
