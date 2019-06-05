import 'package:bkapp_flutter/entity/movie/MovieList.dart';
import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/page/movie/MovieDetailPage.dart';
import 'package:bkapp_flutter/page/user/UserCenterPage.dart';
import 'package:bkapp_flutter/presenter/movie/MovieUpcomingPresenter.dart';
import 'package:bkapp_flutter/presenter/movie/impl/MovieUpcomingPresenterImpl.dart';
import 'package:bkapp_flutter/utils/GenresUtil.dart';
import 'package:bkapp_flutter/view/MovieUpcomingView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../Constants.dart';

class MovieUpcomingPage extends StatefulWidget {
  final MovieUpcomingPageState state = MovieUpcomingPageState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

class MovieUpcomingPageState extends State<MovieUpcomingPage>
    with AutomaticKeepAliveClientMixin
    implements MovieUpcomingView {
  RefreshController _refreshController;
  ScrollController _scrollController;
  List<Results> _items = [];
  MovieUpcomingPresenter _movieUpcomingPresenter;
  int page = 1;

  LoadingStatus status = LoadingStatus.Loading;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _scrollController = ScrollController();
    _refreshController.scrollController = _scrollController;
    _movieUpcomingPresenter = MovieUpcomingPresenterImpl(this);
    _movieUpcomingPresenter.requestUpcomingMovie(page);
  }

  void _onRefresh() {
    setState(() {
      page = 1;
    });
    _movieUpcomingPresenter.requestUpcomingMovie(page);
  }

  void _onLoading() {
    setState(() {
      page = ++page;
    });
    _movieUpcomingPresenter.requestUpcomingMovie(page);
  }

  void _onRetry() {
    setState(() {
      status = LoadingStatus.Loading;
      page = 1;
    });
    _movieUpcomingPresenter.requestUpcomingMovie(page);
  }

  void _jumpToDetail(Results item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MovieDetailPage(item)));
  }

  String _getGenres(List<int> ids) {
    String genres = '';
    if (ids.length == 0) {
      return '无';
    }
    ids.forEach((int i) {
      genres = genres + GenresUtil.instance.getGenre(i) + '/';
    });
    return genres.substring(0, genres.length - 1);
  }

  Widget _itemView(BuildContext context, int index) {
    return Container(
        height: 120,
        child: GestureDetector(
          child: Card(
            child: Row(
              children: <Widget>[
                Hero(tag: _items[index].id, child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: FadeInImage.assetNetwork(
                        width: 80,
                        height: 120,
                        placeholder: "images/movie_placeholder_image.png",
                        image:
                        '${Constants.image_prefix}/w200/${_items[index].poster_path}',
                        fit: BoxFit.cover,
                      ),
                    ))),
                Container(
                  margin: EdgeInsets.only(left: 5, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _items[index].title,
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '原名：${_items[index].original_title}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '类型：${_getGenres(_items[index].genre_ids)}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('评分：', style: TextStyle(fontSize: 12)),
                          Text(
                            _items[index].vote_average,
                            style: TextStyle(
                                fontSize: 12, color: Colors.redAccent),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child:
                                  Text('热度：', style: TextStyle(fontSize: 12))),
                          Text(
                            _items[index].popularity.toString(),
                            style: TextStyle(
                                fontSize: 12, color: Colors.amberAccent),
                          )
                        ],
                      ),
                      Text(
                        '首映：${_items[index].release_date}',
                        style: TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
          ),
          onTap: () {
            _jumpToDetail(_items[index]);
          },
        ));
  }

  Widget _createHeader() {
    return ClassicHeader(
      triggerDistance: 40,
      height: 35,
      refreshingText: '正在刷新',
      completeText: '刷新成功',
      failedText: '刷新失败',
      textStyle: TextStyle(color: Colors.white),
      releaseText: '释放刷新',
      idleText: '下拉刷新',
      refreshingIcon: SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _createFooter() {
    return ClassicFooter(
      triggerDistance: 40,
      height: 35,
      loadingText: '正在加载',
      textStyle: TextStyle(color: Colors.white),
      noDataText: '没有更多了',
      noMoreIcon: Icon(
        Icons.all_inclusive,
        color: Colors.white,
      ),
      idleText: '上拉加载',
      idleIcon: Icon(Icons.arrow_upward),
      loadingIcon: SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }

  Widget _createLoading() {
    return Center(
      child: Row(children: <Widget>[
        SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 1,
            )),
        Container(
          child: Text(
            '加载中..',
          ),
          margin: EdgeInsets.only(left: 10),
        )
      ], mainAxisAlignment: MainAxisAlignment.center),
    );
  }

  Widget _createFail() {
    return Center(
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error, color: Colors.red),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text('请求失败，点击重试'),
            )
          ],
        ),
        onTap: _onRetry,
      ),
    );
  }

  Widget _createList() {
    return SmartRefresher(
      header: _createHeader(),
      footer: _createFooter(),
      child: ListView.builder(
        itemBuilder: _itemView,
        itemCount: _items.length,
        controller: _scrollController,
      ),
      controller: _refreshController,
      enablePullUp: true,
      onLoading: this._onLoading,
      onRefresh: this._onRefresh,
    );
  }

  Widget _createComingUpMovie() {
    if (_items.length == 0) {
      return status == LoadingStatus.Loading
          ? _createLoading()
          : status == LoadingStatus.Success
              ? Center(child: Text('暂无数据'))
              : _createFail();
    } else {
      return _createList();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _createComingUpMovie();
  }

  @override
  void requestMovieUpcomingFail(DioError error) {
    if (_refreshController.isRefresh) {
      _refreshController.refreshFailed();
    } else if (_refreshController.isLoading) {
      _refreshController.loadComplete();
    } else {
      setState(() {
        status = LoadingStatus.Fail;
      });
    }
  }

  @override
  void requestMovieUpcomingSuccess(MovieList movieList) {
    if (_refreshController.isRefresh) {
      setState(() {
        _items = movieList.results;
      });
      _refreshController.refreshCompleted();
    } else if (_refreshController.isLoading) {
      var its = _items;
      its.addAll(movieList.results);
      setState(() {
        _items = its;
      });
      _refreshController.loadComplete();
    } else {
      setState(() {
        status = LoadingStatus.Success;
        _items = movieList.results;
      });
    }
    if (movieList.page >= movieList.total_pages) {
      _refreshController.loadNoData();
    }
  }

  @override
  bool get wantKeepAlive => true;
}

enum LoadingStatus { Loading, Success, Fail }
