import 'package:bkapp_flutter/component/list_helper.dart';
import 'package:bkapp_flutter/component/movie/movie_list_item.dart';
import 'package:bkapp_flutter/entity/enum/loading_status.dart';
import 'package:bkapp_flutter/entity/movie/movie_list.dart';
import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:bkapp_flutter/page/movie/movie_base_page.dart';
import 'package:bkapp_flutter/page/movie/movie_detail_page.dart';
import 'package:bkapp_flutter/presenter/movie/movie_now_playing_presenter.dart';
import 'package:bkapp_flutter/presenter/movie/impl/movie_now_playing_presenterImpl.dart';
import 'package:bkapp_flutter/view/movie/movie_now_playing_view.dart';
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

class MovieNowPlayingPageState extends BaseState<MovieNowPlayingPage>
    with AutomaticKeepAliveClientMixin
    implements MovieNowPlayingView {
  RefreshController _refreshController;
  ScrollController _scrollController = ScrollController();
  List<Results> _items = [];
  MovieNowPlayingPresenter _movieNowPlayingPresenter;
  int _page = 1;

  LoadingStatus _status = LoadingStatus.Loading;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: true);
    _movieNowPlayingPresenter = MovieNowPlayingPresenterImpl(this);
  }

  Widget _itemView(BuildContext context, int index) {
    return MovieListItem(_items[index], _toDetail, 'nowPlaying');
  }

  Widget _createList() {
    return SmartRefresher(
      header: MaterialClassicHeader(),
      enablePullUp: true,
      onRefresh: this._onRefresh,
      onLoading: this._onLoading,
      controller: this._refreshController,
      child: ListView.builder(
        itemBuilder: this._itemView,
        itemCount: _items.length,
        controller: _scrollController,
      ),
    );
  }

  Widget _createNowPlayingMovie() {
    return _status == LoadingStatus.Fail
        ? ListHelper.createFail(_onRetry)
        : _status == LoadingStatus.Loading || _items.length > 0
            ? _createList()
            : ListHelper.createEmpty();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _createNowPlayingMovie();
  }

  void back2Top() {
    if (_items.length > 0) {
      _scrollController.animateTo(0,
          duration: Duration(milliseconds: 800), curve: Curves.decelerate);
    }
  }

  void _onRefresh() {
    _movieNowPlayingPresenter.requestNowPlayingMovie(1);
  }

  void _onLoading() {
    _movieNowPlayingPresenter.requestNowPlayingMovie(++_page);
  }

  void _onRetry() {
    setState(() {
      _status = LoadingStatus.Loading;
    });
    _refreshController.requestRefresh();
  }

  void _toDetail(Results item) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MovieDetailPage(item, 'nowPlaying${item.id}')));
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    _scrollController.dispose();
  }

  @override
  void requestMovieNowPlayingFail(DioError error) {
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
  void requestMovieNowPlayingSuccess(MovieList movieList) {
    if (_refreshController.isRefresh) {
      setState(() {
        _status = LoadingStatus.Success;
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
    }
    _page = movieList.page;
    if (movieList.page >= movieList.total_pages) {
      _refreshController.loadNoData();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
