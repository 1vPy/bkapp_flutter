//Created by 1vPy on 2019/11/1.
import 'package:bkapp_flutter/http/tv_api.dart';
import 'package:bkapp_flutter/presenter/tv/tv_rank_presenter.dart';
import 'package:bkapp_flutter/view/tv/tv_rank_view.dart';

class TvRankPresenterImpl implements TvRankPresenter {
  TvRankView view;

  TvRankPresenterImpl(this.view);

  @override
  void requestTopRatedTv(int page) {
    TvApi.instance.getTopRatedTv(page).listen((response) {
      view.requestTvTopRatedSuccess(response);
    }, onError: (error) {
      view.requestTvTopRatedFail(error);
    });
  }
}
