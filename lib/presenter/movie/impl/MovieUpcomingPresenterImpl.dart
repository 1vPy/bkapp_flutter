import 'package:bkapp_flutter/http/MovieApi.dart';
import 'package:bkapp_flutter/presenter/movie/MovieUpcomingPresenter.dart';
import 'package:bkapp_flutter/view/movie/MovieUpcomingView.dart';

//Created by 1vPy on 2019/10/16.
class MovieUpcomingPresenterImpl implements MovieUpcomingPresenter {
  MovieUpcomingView view;
  MovieUpcomingPresenterImpl(this.view);

  @override
  void requestUpcomingMovie(int page) {
    MovieApi.instance.getUpcomingMovie(page).listen((response){
      view.requestMovieUpcomingSuccess(response);
    },onError: (error){
      view.requestMovieUpcomingFail(error);
    });
  }
}
