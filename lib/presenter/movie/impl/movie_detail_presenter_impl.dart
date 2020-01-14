import 'package:bkapp_flutter/http/movie_api.dart';
import 'package:bkapp_flutter/presenter/movie/movie_detail_presenter.dart';
import 'package:bkapp_flutter/view/movie/movie_detail_view.dart';

//Created by 1vPy on 2019/10/16.
class MovieDetailPresenterImpl implements MovieDetailPresenter {
  MovieDetailView view;

  MovieDetailPresenterImpl(this.view);

  @override
  void requestMovieDetail(int movieId) {
    MovieApi.instance.getMovieDetail(movieId).listen((response){
      view.requestMovieDetailSuccess(response);
    },onError: (error){
      view.requestMovieDetailFail(error);
    });
  }
}
