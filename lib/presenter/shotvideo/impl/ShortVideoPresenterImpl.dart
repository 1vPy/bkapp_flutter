import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/entity/shortvideo/ShortVideoList.dart';
import 'package:bkapp_flutter/presenter/shotvideo/ShortVideoPresenter.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:bkapp_flutter/view/shortvideo/ShortVideoView.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

//Created by 1vPy on 2019/10/16.
class ShortVideoPresenterImpl implements ShortVideoPresenter {
  ShortVideoView view;

  ShortVideoPresenterImpl(this.view);

  @override
  Future<Response<Map>> getShortVideo(int start, int num) {
   return HttpUtil.getInstance(baseUrl: Constants.openEyeUrl)
        .getFuture<Map>('discovery/hot',
        param: {'start': start, 'num': num},
        options: Options(headers: {
          'user-agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36'
        }));
  }
}
