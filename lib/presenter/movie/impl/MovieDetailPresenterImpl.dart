import 'package:bkapp_flutter/http/MovieApi.dart';
import 'package:bkapp_flutter/presenter/movie/MovieDetailPresenter.dart';
import 'package:bkapp_flutter/view/movie/MovieDetailView.dart';

class MovieDetailPresenterImpl implements MovieDetailPresenter {
  MovieDetailView view;

  MovieDetailPresenterImpl(this.view);

  @override
  void requestMovieDetail(int movieId) {
    MovieApi.getInstance().getMovieDetail(movieId).listen((response){
      view.requestMovieDetailSuccess(response);
    },onError: (error){
      view.requestMovieDetailFail(error);
    });
  }
}
