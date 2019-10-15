import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/entity/movie/detail/MovieDetail.dart';
import 'package:bkapp_flutter/presenter/movie/MovieDetailPresenter.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:bkapp_flutter/view/movie/MovieDetailView.dart';

class MovieDetailPresenterImpl extends MovieDetailPresenter {
  MovieDetailView view;

  MovieDetailPresenterImpl(this.view);

  @override
  void requestMovieDetail(int movieId) {
    HttpUtil.getInstance().get<Map>('movie/$movieId', param: {
      'api_key': Constants.key,
      'language': 'zh-CN',
      'append_to_response': 'credits,images'
    }).listen((res) {
      view.requestMovieDetailSuccess(MovieDetail.fromJsonMap(res.data));
    }, onError: (error) {
      view.requestMovieDetailFail(error);
    });
  }
}
