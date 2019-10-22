import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/component/ListHelper.dart';
import 'package:bkapp_flutter/component/movie/MovieListItem.dart';
import 'package:bkapp_flutter/entity/enum/LoadingStatus.dart';
import 'package:bkapp_flutter/entity/movie/MovieList.dart';
import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/page/movie/MovieDetailPage.dart';
import 'package:bkapp_flutter/presenter/movie/MovieNowPlayingPresenter.dart';
import 'package:bkapp_flutter/presenter/movie/impl/MovieNowPlayingPresenterImpl.dart';
import 'package:bkapp_flutter/utils/GenresUtil.dart';
import 'package:bkapp_flutter/view/movie/MovieNowPlayingView.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Created by 1vPy on 2019/10/16.
class MovieNowPlayingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieNowPlayingPageState();
}

class MovieNowPlayingPageState extends State<MovieNowPlayingPage>
    with AutomaticKeepAliveClientMixin
    implements MovieNowPlayingView {
  RefreshController _refreshController;
  List<Results> _items = [];
  MovieNowPlayingPresenter _movieNowPlayingPresenter;
  int page = 1;

  LoadingStatus status = LoadingStatus.Loading;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _movieNowPlayingPresenter = MovieNowPlayingPresenterImpl(this);
    _movieNowPlayingPresenter.requestNowPlayingMovie(page);
  }

  Widget _itemView(BuildContext context, int index) {
    return MovieListItem(_items[index], _toDetail, 'nowPlaying');
  }

//  Widget _itemView(BuildContext context, int index) {
//    return Container(
//        height: 120,
//        child: GestureDetector(
//          child: Card(
//            child: Row(
//              children: <Widget>[
//                Hero(
//                    tag: 'nowPlaying${_items[index].id}',
//                    child: Container(
//                        child: ClipRRect(
//                      borderRadius: BorderRadius.circular(2),
//                      child: FadeInImage.assetNetwork(
//                        width: 80,
//                        height: 120,
//                        placeholder: "images/movie_placeholder_image.png",
//                        image:
//                            '${Constants.image_prefix}/w200/${_items[index].poster_path}',
//                        fit: BoxFit.cover,
//                      ),
//                    ))),
//                Container(
//                  margin: EdgeInsets.only(left: 5, top: 5),
//                  child: Column(
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        _items[index].title,
//                        style: TextStyle(fontSize: 15),
//                      ),
//                      Text(
//                        '原名：${_items[index].original_title}',
//                        style: TextStyle(fontSize: 12),
//                      ),
//                      Text(
//                        '类型：${GenresUtil.instance.id2Genres(_items[index].genre_ids)}',
//                        style: TextStyle(fontSize: 12),
//                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.end,
//                        children: <Widget>[
//                          Text('评分：', style: TextStyle(fontSize: 12)),
//                          Text(
//                            _items[index].vote_average,
//                            style: TextStyle(
//                                fontSize: 12, color: Colors.redAccent),
//                          ),
//                          Container(
//                              margin: EdgeInsets.only(left: 5),
//                              child:
//                                  Text('热度：', style: TextStyle(fontSize: 12))),
//                          Text(
//                            _items[index].popularity.toString(),
//                            style: TextStyle(
//                                fontSize: 12, color: Colors.amberAccent),
//                          )
//                        ],
//                      ),
//                      Text(
//                        '首映：${_items[index].release_date}',
//                        style: TextStyle(fontSize: 12),
//                      )
//                    ],
//                  ),
//                )
//              ],
//            ),
//            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
//          ),
//          onTap: () {
//            _toDetail(_items[index]);
//          },
//        ));
//  }

  Widget _createList() {
    return RefreshConfiguration(
      headerTriggerDistance: 40,
      child: SmartRefresher(
        header: ListHelper.createHeader(),
        footer: ListHelper.createFooter(),
        enablePullUp: true,
        child: ListView.builder(
          itemBuilder: this._itemView,
          itemCount: _items.length,
        ),
        onLoading: this._onRefresh,
        onRefresh: this._onLoading,
        controller: this._refreshController,
      ),
    );
  }

  Widget _createNowPlayingMovie() {
    if (_items.length == 0) {
      return status == LoadingStatus.Loading
          ? ListHelper.createLoading()
          : status == LoadingStatus.Success
              ? Center(child: Text('暂无数据'))
              : ListHelper.createFail(this._onRetry);
    } else {
      return _createList();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _createNowPlayingMovie();
  }

  void _onRefresh() {
    setState(() {
      page = 1;
    });
    _movieNowPlayingPresenter.requestNowPlayingMovie(page);
  }

  void _onLoading() {
    setState(() {
      page = ++page;
    });
    _movieNowPlayingPresenter.requestNowPlayingMovie(page);
  }

  void _onRetry() {
    setState(() {
      status = LoadingStatus.Loading;
      page = 1;
    });
    _movieNowPlayingPresenter.requestNowPlayingMovie(page);
  }

  void _toDetail(Results item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetailPage(item, 'nowPlaying${item.id}')));
  }

  @override
  void requestMovieNowPlayingFail(DioError error) {
    if (_refreshController.isRefresh) {
      _refreshController.refreshFailed();
    } else if (_refreshController.isLoading) {
      _refreshController.loadFailed();
    } else {
      setState(() {
        status = LoadingStatus.Fail;
      });
    }
  }

  @override
  void requestMovieNowPlayingSuccess(MovieList movieList) {
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
