//Created by 1vPy on 2019/11/1.
import 'package:bkapp_flutter/entity/tv/tv_main_entity.dart';
import 'package:bkapp_flutter/http/tv_api.dart';
import 'package:bkapp_flutter/presenter/tv/tv_main_presenter.dart';
import 'package:bkapp_flutter/view/tv/tv_main_view.dart';
import 'package:rxdart/rxdart.dart';

class TvMainPresenterImpl implements TvMainPresenter {
  TvMainView view;

  TvMainPresenterImpl(this.view);

  @override
  void requestTvMainData() {
    Observable.zip3(
        TvApi.instance.getAirTodayTv(1),
        TvApi.instance.getPopularTv(1),
        TvApi.instance.getTopRatedTv(1),
        (a, b, c) => TvMainEntity(a, b, c)).listen((response) {
      view.requestTvMainSuccess(response);
    }, onError: (error) {
      view.requestTvMainFail(error);
    });
  }
}
