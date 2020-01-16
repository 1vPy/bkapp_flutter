//Created by 1vPy on 2019/10/31.
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/component/list_helper.dart';
import 'package:bkapp_flutter/entity/enum/loading_status.dart';
import 'package:bkapp_flutter/entity/tv/tv_main_entity.dart';
import 'package:bkapp_flutter/entity/tv/results.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/page/tv/tv_rank_page.dart';
import 'package:bkapp_flutter/presenter/tv/tv_main_presenter.dart';
import 'package:bkapp_flutter/presenter/tv/impl/tv_main_presenter_impl.dart';
import 'package:bkapp_flutter/view/tv/tv_main_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TvMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TvMainPageState();
}

class TvMainPageState extends BaseState<TvMainPage>
    with AutomaticKeepAliveClientMixin
    implements TvMainView {
  List<Results> _popularItems = [];
  List<Results> _topRateItems = [];
  List<Results> _airTodayItems = [];

  TvMainPresenter _tvMainPresenter;

  RefreshController _refreshController;

  LoadingStatus _status = LoadingStatus.Loading;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _tvMainPresenter = TvMainPresenterImpl(this);
    _tvMainPresenter.requestTvMainData();
  }

  Widget _buildSwiperItem(context, index) {
    return Card(
        child: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: CachedNetworkImage(
            imageUrl:
                '${Constants.image_prefix}/w500/${_airTodayItems[index].backdrop_path}',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(left: 15, bottom: 12),
          child: Text(
            _airTodayItems[index].name,
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        )
      ],
    ));
  }

  Widget _buildSwiperHeader() {
    return Container(
      height: 180,
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Swiper(
        scrollDirection: Axis.horizontal,
        loop: true,
        autoplay: true,
        itemCount: _airTodayItems.length,
        itemBuilder: this._buildSwiperItem,
        pagination: new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                size: 5,
                activeSize: 5,
                activeColor: Colors.blue,
                color: Colors.white)),
        control: new SwiperControl(
            iconNext: Icons.keyboard_arrow_right,
            iconPrevious: Icons.keyboard_arrow_left,
            color: Colors.white),
      ),
    );
  }

  Widget _buildPopularList() {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, right: 5, left: 5),
            alignment: Alignment.topRight,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('近期流行',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                InkWell(
                  child: Text('查看更多'),
                  onTap: () {
                    this.toTvRankPage('近期流行');
                  },
                )
              ],
            ),
          ),
          Container(
            height: 160,
            child: ListView.builder(
              itemCount: _popularItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 3, right: 3, top: 10),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: CachedNetworkImage(
                          width: 80,
                          height: 120,
                          placeholder: (context, url) {
                            return ClipRRect(
                              child: Image.asset(
                                'images/movie_placeholder_image.png',
                                width: 80,
                                height: 120,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            );
                          },
                          imageUrl:
                              '${Constants.image_prefix}/w200/${_popularItems[index].poster_path}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Center(
                          child: Text(
                            _popularItems[index].name,
                            style: TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        width: 80,
                      )
                    ],
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopRatedList() {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, right: 5, left: 5),
            alignment: Alignment.topRight,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('最高评分',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                ),
                InkWell(
                  child: Text('查看更多'),
                  onTap: () {
                    this.toTvRankPage('最高评分');
                  },
                )
              ],
            ),
          ),
          Container(
            height: 160,
            child: ListView.builder(
              itemCount: _topRateItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 3, right: 3, top: 10),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: CachedNetworkImage(
                          width: 80,
                          height: 120,
                          placeholder: (context, url) {
                            return ClipRRect(
                              child: Image.asset(
                                'images/movie_placeholder_image.png',
                                width: 80,
                                height: 120,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            );
                          },
                          imageUrl:
                              '${Constants.image_prefix}/w200/${_topRateItems[index].poster_path}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Center(
                          child: Text(
                            _topRateItems[index].name,
                            style: TextStyle(fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        width: 80,
                      )
                    ],
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _status == LoadingStatus.Loading
        ? ListHelper.createLoading()
        : _status == LoadingStatus.Fail
            ? ListHelper.createFail(_onRetry)
            : SmartRefresher(
                header: MaterialClassicHeader(),
                onRefresh: _onRefresh,
                controller: _refreshController,
                child: SingleChildScrollView(
                  child: Column(children: [
                    _buildSwiperHeader(),
                    _buildPopularList(),
                    _buildTopRatedList()
                  ]),
                ),
              );
  }

  void toTvRankPage(title) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => TvRankPage(title)));
  }

  void _onRetry() {
    _tvMainPresenter.requestTvMainData();
  }

  void _onRefresh() {
    _tvMainPresenter.requestTvMainData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void requestTvMainFail(DioError error) {
    if (_refreshController.isRefresh) {
      _refreshController.refreshFailed();
    }
    setState(() {
      _status = LoadingStatus.Fail;
    });
  }

  @override
  void requestTvMainSuccess(TvMainEntity tvMainEntity) {
    if (_refreshController.isRefresh) {
      _refreshController.refreshCompleted();
    }
    setState(() {
      _status = LoadingStatus.Success;
      _airTodayItems = tvMainEntity.airTodayList.results;
      _popularItems = tvMainEntity.popularList.results;
      _topRateItems = tvMainEntity.topRatedList.results;
    });
  }
}
