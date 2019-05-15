import 'package:bkapp_flutter/entity/TestEntity.dart';
import 'package:bkapp_flutter/entity/results.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart';

class MovieMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MovieMainPageState();
}

class MovieMainPageState extends State<MovieMainPage> {
  RefreshController _refreshController;
  List<Results> _items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController();
    _getData(1);
  }

  void _getData(int page) {
    HttpUtil()
        .get<Map>(
            'http://gank.io/api/xiandu/data/id/appinn/count/20/page/$page')
        .listen((res) {
          List<Results> r = new List();
      TestEntity.fromJsonMap(res).results.forEach((item){
        r.add(item);
      });
      setState(() {
        _items.addAll(r);
      });
    }, onError: (error) {
      print(error.response.statusCode);
    }, onDone: () {
      print('done');
    });
  }

  void _onRefresh() {
    Future.delayed(Duration(seconds: 3), () {
      _getData(1);
      this._refreshController.refreshCompleted();
    });
  }

  void _onLoading() {
    Future.delayed(Duration(seconds: 3), () {
//      _getData(2);
      this._refreshController.loadNoData();
    });
  }

  Widget itemView(BuildContext context, int index) {
    if (index.isOdd) return Divider(height: 2.0);
    return Container(height: 80, child: Text(_items[index].title));
  }

  Widget createHeader(){
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

  Widget createFooter(){
    return ClassicFooter(
      triggerDistance: 40,
      height: 35,
      loadingText: '正在加载',
      textStyle: TextStyle(color: Colors.white),
      noDataText: '没有更多了',
      noMoreIcon: Icon(Icons.all_inclusive,color: Colors.white,),
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SmartRefresher(
        header: createHeader(),
        footer: createFooter(),
        child: ListView.builder(
          itemBuilder: itemView,
          itemCount: _items.length,
        ),
        controller: _refreshController,
        enablePullUp: true,
        onLoading: this._onLoading,
        onRefresh: this._onRefresh,
      ),
    );
  }
}
