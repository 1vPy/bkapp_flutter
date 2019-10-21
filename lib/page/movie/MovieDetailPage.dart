import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/entity/movie/detail/MovieDetail.dart';
import 'package:bkapp_flutter/entity/movie/results.dart';
import 'package:bkapp_flutter/presenter/movie/MovieDetailPresenter.dart';
import 'package:bkapp_flutter/presenter/movie/impl/MovieDetailPresenterImpl.dart';
import 'package:bkapp_flutter/utils/GenresUtil.dart';
import 'package:bkapp_flutter/view/movie/MovieDetailView.dart';
import 'package:dio/src/dio_error.dart';
import 'package:flutter/material.dart';

//Created by 1vPy on 2019/10/16.
class MovieDetailPage extends StatefulWidget {
  final Results item;
  final String tag;

  MovieDetailPage(this.item, this.tag);

  @override
  State<StatefulWidget> createState() {
    return MovieDetailPageState();
  }
}

class MovieDetailPageState extends State<MovieDetailPage>
    implements MovieDetailView {
  MovieDetailPresenter _movieDetailPresenter;
  MovieDetail _movieDetail;
  IconData _iconData = Icons.favorite_border;
  bool _isCollected = false;
  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _movieDetailPresenter = MovieDetailPresenterImpl(this);
    _movieDetailPresenter.requestMovieDetail(widget.item.id);
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return [
      SliverAppBar(
        expandedHeight: 180.0,
        floating: false,
        pinned: true,
        title: Text(
          widget.item.title,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: FadeInImage.assetNetwork(
                fadeInDuration: Duration(seconds: 2),
                placeholder: 'images/movie_placeholder_image.png',
                image:
                    '${Constants.image_prefix}w500/${widget.item.backdrop_path}',
                fit: BoxFit.cover)),
      )
    ];
  }

  Widget _createMovieDetailCard() {
    return Card(
      child: Row(
        children: <Widget>[
          Hero(
              tag: widget.tag,
              child: Container(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: FadeInImage.assetNetwork(
                  width: 80,
                  height: 120,
                  placeholder: "images/movie_placeholder_image.png",
                  image:
                      '${Constants.image_prefix}/w200/${widget.item.poster_path}',
                  fit: BoxFit.cover,
                ),
              ))),
          Container(
            margin: EdgeInsets.only(left: 5, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.item.title,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  '原名：${widget.item.original_title}',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '类型：${GenresUtil.instance.id2Genres(widget.item.genre_ids)}',
                  style: TextStyle(fontSize: 12),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('评分：', style: TextStyle(fontSize: 12)),
                    Text(
                      widget.item.vote_average,
                      style: TextStyle(fontSize: 12, color: Colors.redAccent),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text('热度：', style: TextStyle(fontSize: 12))),
                    Text(
                      widget.item.popularity.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.amberAccent),
                    )
                  ],
                ),
                Text(
                  '首映：${widget.item.release_date}',
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(left: 10, right: 10, top: 10),
    );
  }

  Widget _createItems() {
    if (_movieDetail == null) {
      return Container(
        height: 250,
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
    } else {
      return Column();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: NestedScrollView(
          headerSliverBuilder: _sliverBuilder,
          body: Column(
            children: <Widget>[_createMovieDetailCard(), _createItems()],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: this.onCollectBtnClick,
        child: Icon(_iconData),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void onCollectBtnClick() {
    setState(() {
      _iconData = _isCollected ? Icons.favorite_border : Icons.favorite;
      _isCollected = !_isCollected;
    });
    _scaffoldkey.currentState.removeCurrentSnackBar();
    _scaffoldkey.currentState
        .showSnackBar(SnackBar(content: Text(_isCollected ? '收藏成功' : '取消成功')));
  }

  @override
  void requestMovieDetailFail(DioError error) {}

  @override
  void requestMovieDetailSuccess(MovieDetail detail) {
    setState(() {
      _movieDetail = detail;
    });
  }
}
