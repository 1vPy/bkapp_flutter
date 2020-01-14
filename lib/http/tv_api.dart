//Created by 1vPy on 2019/11/1.
import 'package:bkapp_flutter/constants.dart';
import 'package:bkapp_flutter/entity/tv/tv_list.dart';
import 'package:bkapp_flutter/utils/http_util.dart';
import 'package:rxdart/subjects.dart';

class TvApi {
  static final TvApi instance = TvApi._internal();

  TvApi._internal();

  PublishSubject<TvList> getTopRatedTv(int page) {
    PublishSubject<TvList> _subject = PublishSubject();
    HttpUtil.getInstance().get<Map>('tv/top_rated', param: {
      'api_key': Constants.key,
      "page": page,
      'language': 'zh-CN'
    }).listen((response) {
      _subject.add(TvList.fromJsonMap(response.data));
    }, onError: (error) {
      _subject.addError(error);
    });
    return _subject;
  }

  PublishSubject<TvList> getPopularTv(int page) {
    PublishSubject<TvList> _subject = PublishSubject();
    HttpUtil.getInstance().get<Map>('tv/popular', param: {
      'api_key': Constants.key,
      "page": page,
      'language': 'zh-CN'
    }).listen((response) {
      _subject.add(TvList.fromJsonMap(response.data));
    }, onError: (error) {
      _subject.addError(error);
    });
    return _subject;
  }

  PublishSubject<TvList> getAirTodayTv(int page) {
    PublishSubject<TvList> _subject = PublishSubject();
    HttpUtil.getInstance().get<Map>('tv/airing_today', param: {
      'api_key': Constants.key,
      "page": page,
      'language': 'zh-CN'
    }).listen((response) {
      _subject.add(TvList.fromJsonMap(response.data));
    }, onError: (error) {
      _subject.addError(error);
    });
    return _subject;
  }
}
