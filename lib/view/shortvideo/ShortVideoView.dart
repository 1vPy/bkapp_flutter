
import 'package:bkapp_flutter/entity/shortvideo/ShortVideoList.dart';
import 'package:dio/dio.dart';

//Created by 1vPy on 2019/10/16.
abstract class ShortVideoView {
  void requestShortVideoSuccess(ShortVideoList shortVideoList);

  void requestShortVideoFail(DioError error);
}