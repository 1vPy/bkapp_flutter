
import 'package:bkapp_flutter/entity/shortvideo/ShortVideoList.dart';
import 'package:dio/dio.dart';

abstract class ShortVideoView {
  void requestShortVideoSuccess(ShortVideoList shortVideoList);

  void requestShortVideoFail(DioError error);
}