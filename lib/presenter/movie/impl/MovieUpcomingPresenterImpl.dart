import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/entity/movie/MovieList.dart';
import 'package:bkapp_flutter/presenter/movie/MovieUpcomingPresenter.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:bkapp_flutter/view/MovieUpcomingView.dart';

class MovieUpcomingPresenterImpl extends MovieUpcomingPresenter {
  MovieUpcomingView view;
  MovieUpcomingPresenterImpl(this.view);

  @override
  void requestUpcomingMovie(int page) {
    new HttpUtil().get<Map>('movie/upcoming', param: {
      'api_key': Constants.key,
      "page": page,
      'language': 'zh-CN'
    }).listen((response) {
      view.requestMovieUpcomingSuccess(MovieList.fromJsonMap(response));
    }, onError: (error) {
      view.requestMovieUpcomingFail(error);
    });
  }
}
