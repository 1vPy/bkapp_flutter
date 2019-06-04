import 'package:bkapp_flutter/entity/TestEntity.dart';
import 'package:bkapp_flutter/entity/results.dart';
import 'package:bkapp_flutter/presenter/movie/MovieMainPresenter.dart';
import 'package:bkapp_flutter/utils/HttpUtil.dart';
import 'package:bkapp_flutter/view/MovieMainView.dart';

import '../../../Constants.dart';


class MovieMainPresenterImpl extends MovieMainPresenter{
  MovieMainView view;
  MovieMainPresenterImpl(this.view);

  @override
  void requestMovie(int page) {
    HttpUtil().get<Map>('http://gank.io/api/xiandu/data/id/appinn/count/20/page/$page')
        .listen((res) {
          view.requestMovieSuccess(TestEntity.fromJsonMap(res));
    }, onError: (error) {
      view.requestMovieFail(error);
    });
  }

}