import 'package:bkapp_flutter/component/ListHelper.dart';
import 'package:bkapp_flutter/component/movie/MovieListItem.dart';
import 'package:bkapp_flutter/entity/enum/LoadingStatus.dart';
import 'package:bkapp_flutter/entity/movie/MovieList.dart';
import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/page/BaseState.dart';
import 'package:bkapp_flutter/page/movie/MovieBasePage.dart';
import 'package:bkapp_flutter/page/movie/MovieDetailPage.dart';
import 'package:bkapp_flutter/presenter/movie/MovieUpcomingPresenter.dart';
import 'package:bkapp_flutter/presenter/movie/impl/MovieUpcomingPresenterImpl.dart';
import 'package:bkapp_flutter/view/movie/MovieUpcomingView.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Created by 1vPy on 2019/10/16.
class MovieUpcomingPage extends MovieBasePage {
  final MovieUpcomingPageState state = MovieUpcomingPageState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

  @override
  void back2Top() {
    state.back2Top();
  }
}

class MovieUpcomingPageState extends BaseState<MovieUpcomingPage>
    with AutomaticKeepAliveClientMixin
    implements MovieUpcomingView {
  RefreshController _refreshController;
  ScrollController _scrollController = ScrollController();
  List<Results> _items = [];
  MovieUpcomingPresenter _movieUpcomingPresenter;
  int page = 1;

  LoadingStatus status = LoadingStatus.Loading;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController();
    _movieUpcomingPresenter = MovieUpcomingPresenterImpl(this);
    _movieUpcomingPresenter.requestUpcomingMovie(page);
  }

  Widget _itemView(BuildContext context, int index) {
    return MovieListItem(_items[index], _toDetail, 'upComing');
  }

  Widget _createList() {
    return RefreshConfiguration(
      headerTriggerDistance: 35,
      hideFooterWhenNotFull: true,
      maxOverScrollExtent: 35,
      child: SmartRefresher(
        header: ListHelper.createHeader(),
        footer: ListHelper.createFooter(),
        child: ListView.builder(
          itemBuilder: _itemView,
          itemCount: _items.length,
          controller: _scrollController,
        ),
        controller: _refreshController,
        enablePullUp: true,
        onLoading: this._onLoading,
        onRefresh: this._onRefresh,
      ),
    );
  }

  Widget _createComingUpMovie() {
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
    return _createComingUpMovie();
  }

  void back2Top() {
    if (_items.length > 0) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 800), curve: Curves.decelerate);
    }
  }

  void _onRefresh() {
    _movieUpcomingPresenter.requestUpcomingMovie(1);
  }

  void _onLoading() {
    _movieUpcomingPresenter.requestUpcomingMovie(++page);
  }

  void _onRetry() {
    setState(() {
      status = LoadingStatus.Loading;
    });
    _movieUpcomingPresenter.requestUpcomingMovie(1);
  }

  void _toDetail(Results item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetailPage(item, 'upComing${item.id}')));
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
    page = movieList.page;
    if (movieList.page >= movieList.total_pages) {
      _refreshController.loadNoData();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
