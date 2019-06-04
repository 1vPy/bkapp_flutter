import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'dart:convert';

class HttpUtil {
  static final HttpUtil instance = new HttpUtil._internal();
  Dio _dio;
  BaseOptions _baseOptions;

  HttpUtil._internal() {
    _baseOptions = new BaseOptions(
        connectTimeout: 15 * 1000, receiveTimeout: 15 * 1000, baseUrl: 'https://api.themoviedb.org/3/');
    _dio = new Dio(_baseOptions);
    _dio.interceptors.add(LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true));
  }

  factory HttpUtil() {
    return instance;
  }

  PublishSubject<T> get<T>(String url, {Map<String, dynamic> param}) {
    Observable<Response> observable = Observable.fromFuture(_dio.get(url, queryParameters: param));
    PublishSubject<T> publishSubject = PublishSubject();
    observable.listen((res) {
      publishSubject.add(res.data);
    }, onError: (error) {
      publishSubject.addError(error);
    });
    return publishSubject;
  }

  PublishSubject<T> post<T>(String url, {Map<String, dynamic> param}) {
    Future<Response<T>> future = _dio.post(url, queryParameters: param);
    Observable<Response<T>> observable = Observable.fromFuture(future);
    PublishSubject<T> publishSubject = PublishSubject();
    observable.listen((res) {
      publishSubject.add(res.data);
    }, onError: (error) {
      publishSubject.addError(error);
    });
    return publishSubject;
  }
}
