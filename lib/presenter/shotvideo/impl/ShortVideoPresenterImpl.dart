import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/entity/shortvideo/ShortVideoList.dart';
import 'package:bkapp_flutter/presenter/shotvideo/ShortVideoPresenter.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:bkapp_flutter/view/shortvideo/ShortVideoView.dart';
import 'package:dio/dio.dart';

class ShortVideoPresenterImpl implements ShortVideoPresenter {
  ShortVideoView view;

  ShortVideoPresenterImpl(this.view);

  @override
  void getShortVideo(int start, int num) {
    HttpUtil.getInstance(baseUrl: Constants.openEyeUrl)
        .get('discovery/hot',
            param: {'start': start, 'num': num},
            options: Options(headers: {
              'user-agent':
                  'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/77.0.3865.120 Safari/537.36'
            }))
        .listen((res) {
      view.requestShortVideoSuccess(ShortVideoList.fromJsonMap(res.data));
    }, onError: (error) {
      view.requestShortVideoFail(error);
    });
  }
}
