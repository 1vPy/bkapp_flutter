import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/component/ListHelper.dart';
import 'package:bkapp_flutter/component/movie/MovieListItem.dart';
import 'package:bkapp_flutter/entity/enum/LoadingStatus.dart';
import 'package:bkapp_flutter/entity/movie/MovieList.dart';
import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/page/movie/MovieBasePage.dart';
import 'package:bkapp_flutter/page/movie/MovieDetailPage.dart';
import 'package:bkapp_flutter/presenter/movie/MovieNowPlayingPresenter.dart';
import 'package:bkapp_flutter/presenter/movie/impl/MovieNowPlayingPresenterImpl.dart';
import 'package:bkapp_flutter/utils/GenresUtil.dart';
import 'package:bkapp_flutter/view/movie/MovieNowPlayingView.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Created by 1vPy on 2019/10/16.
class MovieNowPlayingPage extends MovieBasePage {
  final MovieNowPlayingPageState state = MovieNowPlayingPageState();

  @override
  State<StatefulWidget> createState() => state;

  @override
  void back2Top() {
    state.back2Top();
  }
}

class MovieNowPlayingPageState extends State<MovieNowPlayingPage>
    with AutomaticKeepAliveClientMixin
    implements MovieNowPlayingView {
  RefreshController _refreshController;
  ScrollController _scrollController = ScrollController();
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
          controller: _scrollController,
        ),
        onRefresh: this._onRefresh,
        onLoading: this._onLoading,
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

  void back2Top() {
    if (status == LoadingStatus.Success) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 800), curve: Curves.decelerate);
    }
  }

  void _onRefresh() {
    _movieNowPlayingPresenter.requestNowPlayingMovie(1);
  }

  void _onLoading() {
    _movieNowPlayingPresenter.requestNowPlayingMovie(++page);
  }

  void _onRetry() {
    setState(() {
      status = LoadingStatus.Loading;
    });
    _movieNowPlayingPresenter.requestNowPlayingMovie(1);
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
    page = movieList.page;
    if (movieList.page >= movieList.total_pages) {
      _refreshController.loadNoData();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
