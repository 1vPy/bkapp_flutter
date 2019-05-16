import 'package:bkapp_flutter/entity/TestEntity.dart';
import 'package:bkapp_flutter/entity/results.dart';
import 'package:bkapp_flutter/presenter/MovieMainPresenter.dart';
import 'package:bkapp_flutter/presenter/impl/MovieMainPresenterImpl.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:bkapp_flutter/view/MovieMainView.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart';

class MovieMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieMainPageState();
}

class MovieMainPageState extends State<MovieMainPage> implements MovieMainView  {
  RefreshController _refreshController;
  ScrollController _scrollController;
  List<Results> _items = [];
  MovieMainPresenter _movieMainPresenter;
  int page = 1;
  bool flbVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController();
    _scrollController = ScrollController();
    _refreshController.scrollController = _scrollController;
    _movieMainPresenter = MovieMainPresenterImpl(this);
    _movieMainPresenter.requestMovie(page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent + 80) {
        if (flbVisible != false) {
          setState(() {
            flbVisible = false;
          });
        }
      } else {
        if (flbVisible != true) {
          setState(() {
            flbVisible = true;
          });
        }
      }
    });
  }

  void _onRefresh() {
    setState(() {
      page = 1;
    });
    _movieMainPresenter.requestMovie(page);
  }

  void _onLoading() {
    setState(() {
      page = ++page;
    });
    _movieMainPresenter.requestMovie(page);
  }

  Widget itemView(BuildContext context, int index) {
    if (index.isOdd) return Divider(height: 2.0);
    return Container(
      height: 60,
        child: GestureDetector(
          child: Text(_items[index].title),
          onTap: () {},
        ));
  }

  Widget createHeader() {
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

  Widget createFooter() {
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

  Widget createHotMovie() {
    return Stack(
      children: <Widget>[
        SmartRefresher(
          header: createHeader(),
          footer: createFooter(),
          child: ListView.builder(
            itemBuilder: itemView,
            itemCount: _items.length,
            controller: _scrollController,
          ),
          controller: _refreshController,
          enablePullUp: true,
          onLoading: this._onLoading,
          onRefresh: this._onRefresh,
        ),
        Positioned(
          child: Visibility(
            child: FloatingActionButton(
              onPressed: () {
                _refreshController.scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: ElasticOutCurve());
              },
              child: Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.blue,
            ),
            visible: flbVisible,
          ),
          right: 20,
          bottom: 20,
        )
      ],
    );
  }

  Widget createFloatActionButton() {
    return Positioned(
      child: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            _refreshController.scrollController.animateTo(0,
                duration: Duration(milliseconds: 500),
                curve: ElasticOutCurve());
          },
          child: Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.blue,
        ),
        visible: flbVisible,
      ),
      right: 20,
      bottom: 20,
    );
  }

  Widget createComingUpMovie() {
    return Stack(
      children: <Widget>[
        SmartRefresher(
          header: createHeader(),
          footer: createFooter(),
          child: ListView.builder(
            itemBuilder: itemView,
            itemCount: _items.length,
            controller: _scrollController,
          ),
          controller: _refreshController,
          enablePullUp: true,
          onLoading: this._onLoading,
          onRefresh: this._onRefresh,
        ),
        createFloatActionButton()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: PageView(
          children: <Widget>[createHotMovie(), createComingUpMovie()],));
  }

  @override
  void requestMovieFail(DioError error) {
    if (_refreshController.isRefresh) {
      _refreshController.refreshFailed();
    } else if (_refreshController.isLoading) {
      _refreshController.loadComplete();
    } else {}
  }

  @override
  void requestMovieSuccess(TestEntity entity) {
    if (_refreshController.isRefresh) {
      setState(() {
        _items = entity.results;
      });
      if (entity.results.length <= 0) {
        _refreshController.refreshCompleted();
        _refreshController.loadNoData();
      } else {
        _refreshController.refreshCompleted();
      }
    } else if (_refreshController.isLoading) {
      var its = _items;
      its.addAll(entity.results);
      setState(() {
        _items = its;
      });
      if (entity.results.length <= 0) {
        _refreshController.loadComplete();
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    } else {
      setState(() {
        _items = entity.results;
      });
      if (entity.results.length <= 0) {
        _refreshController.loadNoData();
      }
    }
  }
}
