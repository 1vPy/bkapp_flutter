import 'package:bkapp_flutter/http/movie_api.dart';
import 'package:bkapp_flutter/presenter/movie/movie_now_playing_presenter.dart';
import 'package:bkapp_flutter/view/movie/movie_now_playing_view.dart';

//Created by 1vPy on 2019/10/16.
class MovieNowPlayingPresenterImpl implements MovieNowPlayingPresenter {
  MovieNowPlayingView view;

  MovieNowPlayingPresenterImpl(this.view);

  @override
  void requestNowPlayingMovie(int page) {
    MovieApi.instance.getNowPlayingMovie(page).listen((response) {
      view.requestMovieNowPlayingSuccess(response);
    }, onError: (error) {
      view.requestMovieNowPlayingFail(error);
    });
  }
}
