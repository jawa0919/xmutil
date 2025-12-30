import 'package:dio/dio.dart';

import 'app_api.dart';

/// 用户管理
class UserApi {
  UserApi._();

  /// 登录获取验证码
  static Future<SimpleResponse> loginCode(String phoneNo) async {
    var dataRes = await AppApi().get(
      '/user/login/code/$phoneNo',
      autoToken: false,
    );
    return SimpleResponse.fromJson(dataRes);
  }

  /// 用户登录
  static Future<SimpleResponse> login(String phoneNo, String code) async {
    var dataRes = await AppApi().post(
      '/user/login',
      autoToken: false,
      data: {'phoneNo': phoneNo, 'code': code},
    );
    return SimpleResponse.fromJson(dataRes);
  }

  /// 用户信息
  static Future<SimpleResponse> info() async {
    var dataRes = await AppApi().get('/user/info', autoToken: true);
    return SimpleResponse.fromJson(dataRes);
  }

  /// 退出登录
  static Future<SimpleResponse> logout() async {
    var dataRes = await AppApi().delete(
      '/user/logout',
      autoToken: true,
      options: Options(extra: {'ignoreException': true}),
    );
    return SimpleResponse.fromJson(dataRes);
  }
}
