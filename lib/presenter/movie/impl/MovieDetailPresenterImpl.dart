import 'package:bkapp_flutter/http/MovieApi.dart';
import 'package:bkapp_flutter/presenter/movie/MovieDetailPresenter.dart';
import 'package:bkapp_flutter/view/movie/MovieDetailView.dart';

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
