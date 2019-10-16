import 'package:bkapp_flutter/http/MovieApi.dart';
import 'package:bkapp_flutter/presenter/movie/MovieNowPlayingPresenter.dart';
import 'package:bkapp_flutter/view/movie/MovieNowPlayingView.dart';

//Created by 1vPy on 2019/10/16.
class MovieNowPlayingPresenterImpl implements MovieNowPlayingPresenter {
  MovieNowPlayingView view;

  MovieNowPlayingPresenterImpl(this.view);

  @override
  void requestNowPlayingMovie(int page) {
    MovieApi.getInstance().getNowPlayingMovie(page).listen((response) {
      view.requestMovieNowPlayingSuccess(response);
    }, onError: (error) {
      view.requestMovieNowPlayingFail(error);
    });
  }
}
