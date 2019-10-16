import 'package:bkapp_flutter/http/MovieApi.dart';
import 'package:bkapp_flutter/presenter/movie/MovieUpcomingPresenter.dart';
import 'package:bkapp_flutter/view/movie/MovieUpcomingView.dart';

class MovieUpcomingPresenterImpl implements MovieUpcomingPresenter {
  MovieUpcomingView view;
  MovieUpcomingPresenterImpl(this.view);

  @override
  void requestUpcomingMovie(int page) {
    MovieApi.getInstance().getUpcomingMovie(page).listen((response){
      view.requestMovieUpcomingSuccess(response);
    },onError: (error){
      view.requestMovieUpcomingFail(error);
    });
  }
}
