import 'package:bkapp_flutter/Constants.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

//Created by 1vPy on 2019/10/16.
class HttpUtil {
  static final HttpUtil _instance = HttpUtil._internal();
  Dio _dio;
  BaseOptions _baseOptions;

  static HttpUtil getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名，比如cdn和kline首次的http请求
  HttpUtil _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpUtil _normal() {
    if (_dio != null) {
      if (_dio.options.baseUrl != Constants.theMovieDBUrl) {
        _dio.options.baseUrl = Constants.theMovieDBUrl;
      }
    }
    return this;
  }

  HttpUtil._internal() {
    _baseOptions = new BaseOptions(
        connectTimeout: 15 * 1000,
        receiveTimeout: 15 * 1000,
        baseUrl: Constants.theMovieDBUrl);
    _dio = new Dio(_baseOptions);
    _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true));
  }


  Observable<Response<T>> get<T>(String url,
      {Map<String, dynamic> param, Options options}) {
    return Observable.fromFuture(
        _dio.get(url, queryParameters: param, options: options));
  }

  Observable<Response<T>> post<T>(String url, {Map<String, dynamic> param}) {
    return Observable.fromFuture(_dio.post(url, queryParameters: param));
  }
}
