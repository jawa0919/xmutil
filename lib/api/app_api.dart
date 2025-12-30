import 'dart:async';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

import '../app_import.dart';

class AppApi {
  static final AppApi _instance = AppApi._internal();
  factory AppApi() => _instance;

  late Dio dio;

  AppApi._internal() {
    dio = HttpUtil.create(ServerStore.to.apiHost);
    dio.interceptors.add(CookieManager(CookieJar()));
    dio.interceptors.add(AppApiInterceptor());
  }

  void updateBaseUrl(String val) {
    debugPrint('app_api.dart~updateBaseUrl: $val');
    dio.options.baseUrl = val;
  }

  Future<T?> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool autoToken = true,
    Map<String, dynamic> cacheSetting = const {},
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?.addAll({
      'autoToken': autoToken,
      'cacheSetting': cacheSetting,
    });
    var response = await dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool autoToken = true,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?.addAll({'autoToken': autoToken});
    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool autoToken = true,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?.addAll({'autoToken': autoToken});
    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool autoToken = true,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?.addAll({'autoToken': autoToken});
    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool autoToken = true,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?.addAll({'autoToken': autoToken});
    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }

  Future head(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool autoToken = true,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra?.addAll({'autoToken': autoToken});
    var response = await dio.head(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
    );
    return response.data;
  }
}

class AppApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (UserStore.to.hasToken == true) {
      options.headers.update(
        'Authorization',
        (value) => UserStore.to.token,
        ifAbsent: () => UserStore.to.token,
      );
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (response.data is Map<String, dynamic>) {
      final rd = response.data as Map<String, dynamic>;
      if (rd['code'] != 200) {
        ExDialog.showToast(rd['message'] ?? rd['msg'] ?? '错误未知');
      }
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    ExDialog.dismiss();
    debugPrint('app_api.dart~onError: $err');
    final se = await HttpUtil.createSimpleException(err);
    if (err.requestOptions.extra['ignoreException'] == true) {
      final r = Response(data: se.toJson(), requestOptions: err.requestOptions);
      return handler.resolve(r);
    }
    ExDialog.showToast(se.message);
    switch (se.code) {
      case 401:
        UserStore.to.clearToken();
        UserStore.to.offAndToLoginPage('登陆已超时,请重新登陆');
      default:
    }
    final r = Response(data: se.toJson(), requestOptions: err.requestOptions);
    return handler.resolve(r);
  }
}

class SimpleResponse<T> {
  final int code;
  final String message;
  final T? data;

  SimpleResponse({required this.code, required this.message, this.data});

  factory SimpleResponse.fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic>)? fromMapT,
  }) {
    return SimpleResponse<T>(
      code: json['code'],
      message: json['message'] ?? json['msg'] ?? '',
      data: fromMapT?.call(json['data']) ?? json['data'],
    );
  }

  Map<String, dynamic> toJson() => {
    'code': code,
    'message': message,
    'data': data,
  };

  bool get success => code == 200;

  @override
  String toString() {
    return 'SimpleResponse{code: $code, message: $message, data: $data}';
  }
}
