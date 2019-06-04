import 'package:bkapp_flutter/entity/movie/MovieList.dart';
import 'package:dio/dio.dart';

abstract class MovieUpcomingView {
  void requestMovieUpcomingSuccess(MovieList movieList);

  void requestMovieUpcomingFail(DioError error);
}
