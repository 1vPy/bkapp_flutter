import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//Created by 1vPy on 2019/10/16.
class ListHelper {
  static Widget createHeader() {
    return ClassicHeader(
      height: 40,
      refreshingText: '正在刷新',
      completeText: '刷新成功',
      failedText: '刷新失败',
      textStyle: TextStyle(color: Colors.white),
      releaseText: '释放刷新',
      releaseIcon: Icon(Icons.refresh, color: Colors.blue),
      idleText: '下拉刷新',
      idleIcon: Icon(
        Icons.arrow_downward,
        color: Colors.blue,
      ),
      failedIcon: Icon(
        Icons.info,
        color: Colors.red,
      ),
      refreshingIcon: SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ),
    );
  }

  static Widget createFooter() {
    return ClassicFooter(
      height: 40,
      loadingText: '正在加载',
      textStyle: TextStyle(color: Colors.white),
      noDataText: '没有更多了',
      noMoreIcon: Icon(
        Icons.all_inclusive,
        color: Colors.blue,
      ),
      idleText: '上拉加载',
      idleIcon: Icon(
        Icons.arrow_upward,
        color: Colors.blue,
      ),
      failedIcon: Icon(
        Icons.info,
        color: Colors.red,
      ),
      failedText: '加载失败,点击重试',
      loadingIcon: SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
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
              strokeWidth: 2,
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
    return Center(
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.network_check,
              color: Colors.grey,
              size: 80,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: MaterialButton(
                color: Colors.blue,
                child: Text('点击重试'),
                onPressed: _onRetry,
              ),
            )
          ],
        ),
        onTap: _onRetry,
      ),
    );
  }

  static Widget createEmpty() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.remove_from_queue,
          color: Colors.grey,
          size: 80,
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text('没有数据哦..!'),
        )
      ],
    ));
  }
}
