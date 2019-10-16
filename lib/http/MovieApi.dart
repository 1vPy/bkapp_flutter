import 'package:bkapp_flutter/Constants.dart';
import 'package:bkapp_flutter/entity/movie/MovieList.dart';
import 'package:bkapp_flutter/entity/movie/detail/MovieDetail.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:rxdart/rxdart.dart';

//Created by 1vPy on 2019/10/16.
class MovieApi {
  static final MovieApi _instance = MovieApi._internal();

  static MovieApi getInstance() {
    return _instance;
  }

  MovieApi._internal();

  PublishSubject<MovieList> getUpcomingMovie(int page) {
    PublishSubject<MovieList> _subject = PublishSubject();
    HttpUtil.getInstance().get<Map>('movie/upcoming', param: {
      'api_key': Constants.key,
      "page": page,
      'language': 'zh-CN'
    }).listen((response) {
      _subject.add(MovieList.fromJsonMap(response.data));
    }, onError: (error) {
      _subject.addError(error);
    });
    return _subject;
  }

  PublishSubject<MovieList> getNowPlayingMovie(int page) {
    PublishSubject<MovieList> _subject = PublishSubject();
    HttpUtil.getInstance().get<Map>('movie/now_playing', param: {
      'api_key': Constants.key,
      "page": page,
      'language': 'zh-CN'
    }).listen((response) {
      _subject.add(MovieList.fromJsonMap(response.data));
    }, onError: (error) {
      _subject.addError(error);
    });
    return _subject;
  }

  PublishSubject<MovieDetail> getMovieDetail(int movieId) {
    PublishSubject<MovieDetail> _subject = PublishSubject();
    HttpUtil.getInstance().get<Map>('movie/$movieId', param: {
      'api_key': Constants.key,
      'language': 'zh-CN',
      'append_to_response': 'credits,images'
    }).listen((response) {
      _subject.add(MovieDetail.fromJsonMap(response.data));
    }, onError: (error) {
      _subject.addError(error);
    });

    return _subject;
  }
}
