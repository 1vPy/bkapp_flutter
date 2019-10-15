import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListHelper {
  static Widget createHeader() {
    return ClassicHeader(
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

  static Widget createFooter() {
    return ClassicFooter(
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

  static Widget createLoading() {
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

  static Widget createFail(Function _onRetry) {
    return  Center(
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
}
