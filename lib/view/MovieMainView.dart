import 'package:bkapp_flutter/entity/TestEntity.dart';
import 'package:dio/dio.dart';

abstract class MovieMainView{
  void requestMovieSuccess(TestEntity entity);

  void requestMovieFail(DioError error);
}