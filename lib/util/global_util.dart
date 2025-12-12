import 'dart:io' show Platform;
import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/services.dart' show SystemUiMode, SystemChrome;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding, debugPrint;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart' show launchUrlString;
import 'package:share_plus/share_plus.dart';

class GlobalUtil {
  GlobalUtil._();

  // 本地存储和文件夹路径
  static late SharedPreferences pref;
  static late String docsDir;
  static late String tempDir;

  // 设备信息
  static Map<String, dynamic>? _deviceInfo;
  static String get systemVersion =>
      _deviceInfo?['version']?['sdkInt']?.toString() ??
      _deviceInfo?['systemVersion']?.toString() ??
      '0';
  static double get sdkInt => double.parse(systemVersion.split('.').first);
  static get _brand => _deviceInfo?['brand'] ?? _deviceInfo?['model'] ?? '';
  static String get brand => _brand.toString().toLowerCase();
  static get _model => _deviceInfo?['model'] ?? _deviceInfo?['modelName'] ?? '';
  static String get model => _model.toString().toLowerCase();

  // 应用信息
  static PackageInfo? _packageInfo;
  static String get appName => _packageInfo?.appName ?? '';
  static String get appId => _packageInfo?.packageName ?? '';
  static String get buildVersion => _packageInfo?.version ?? '';
  static String get buildNumber => _packageInfo?.buildNumber ?? '';
  static String get buildSignature => _packageInfo?.buildSignature ?? '';
  static String get appUserAgent => '$appId($buildVersion;$buildNumber)';

  // 屏幕信息
  static final Map<String, dynamic> _screenInfo = {};
  static double get displayWidth => _screenInfo['displayWidth'] ?? 0;
  static double get displayHeight => _screenInfo['displayHeight'] ?? 0;
  static double get windowWidth => _screenInfo['windowWidth'] ?? 0;
  static double get windowHeight => _screenInfo['windowHeight'] ?? 0;
  static double get devicePixelRatio => _screenInfo['devicePixelRatio'] ?? 0;
  static double get viewPaddingTop => _screenInfo['viewPaddingTop'] ?? 0;
  static double get viewPaddingBottom => _screenInfo['viewPaddingBottom'] ?? 0;
  static double get viewPaddingLeft => _screenInfo['viewPaddingLeft'] ?? 0;
  static double get viewPaddingRight => _screenInfo['viewPaddingRight'] ?? 0;

  /// 初始化
  static Future<SharedPreferences> init() async {
    debugPrint('global_util.dart~init: ');
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    pref = await SharedPreferences.getInstance();
    try {
      docsDir = (await getApplicationDocumentsDirectory()).path;
      tempDir = (await getTemporaryDirectory()).path;
    } catch (e) {
      docsDir = '/';
      tempDir = '/';
    }
    debugPrint('global_util.dart~docsDir: $docsDir');
    debugPrint('global_util.dart~tempDir: $tempDir');
    _deviceInfo ??= (await DeviceInfoPlugin().deviceInfo).data;
    debugPrint('global_util.dart~_deviceInfo: $_deviceInfo');
    _packageInfo ??= await PackageInfo.fromPlatform();
    debugPrint('global_util.dart~_packageInfo: $_packageInfo');
    PlatformDispatcher.instance.onMetricsChanged = () {
      debugPrint('global_util.dart~onMetricsChanged: ');
      final v = PlatformDispatcher.instance.views.last;
      _screenInfo.addAll({'displayWidth': v.display.size.width});
      _screenInfo.addAll({'displayHeight': v.display.size.height});
      _screenInfo.addAll({'windowWidth': v.physicalSize.width});
      _screenInfo.addAll({'windowHeight': v.physicalSize.height});
      _screenInfo.addAll({'devicePixelRatio': v.devicePixelRatio});
      _screenInfo.addAll({'viewPaddingTop': v.viewPadding.top});
      _screenInfo.addAll({'viewPaddingBottom': v.viewPadding.bottom});
      _screenInfo.addAll({'viewPaddingLeft': v.viewPadding.left});
      _screenInfo.addAll({'viewPaddingRight': v.viewPadding.right});
      debugPrint('global_util.dart~_screenInfo: $_screenInfo');
    };
    final v = PlatformDispatcher.instance.views.last;
    _screenInfo.addAll({'displayWidth': v.display.size.width});
    _screenInfo.addAll({'displayHeight': v.display.size.height});
    _screenInfo.addAll({'windowWidth': v.physicalSize.width});
    _screenInfo.addAll({'windowHeight': v.physicalSize.height});
    _screenInfo.addAll({'devicePixelRatio': v.devicePixelRatio});
    _screenInfo.addAll({'viewPaddingTop': v.viewPadding.top});
    _screenInfo.addAll({'viewPaddingBottom': v.viewPadding.bottom});
    _screenInfo.addAll({'viewPaddingLeft': v.viewPadding.left});
    _screenInfo.addAll({'viewPaddingRight': v.viewPadding.right});
    debugPrint('global_util.dart~_screenInfo: $_screenInfo');
    return pref;
  }

  static bool get isProduct => bool.fromEnvironment('dart.vm.product');
  static bool get isWeb => bool.fromEnvironment('dart.library.js_util');
  static bool get isAndroid => Platform.isAndroid;
  static bool get isIOS => Platform.isIOS;

  /// android sdk21-android 5.0-Lollipop
  static bool get isAndroidSdk21 => isAndroid && sdkInt >= 21;

  /// android sdk24-android 7.0-Nougat
  static bool get isAndroidSdk24 => isAndroid && sdkInt >= 24;

  /// android sdk27-android 8.1-Oreo
  static bool get isAndroidSdk27 => isAndroid && sdkInt >= 27;

  /// android sdk28-android 9-Pie
  static bool get isAndroidSdk28 => isAndroid && sdkInt >= 28;

  /// android sdk29-android 10-Q
  static bool get isAndroidSdk29 => isAndroid && sdkInt >= 29;

  /// android sdk30-android 11-R
  static bool get isAndroidSdk30 => isAndroid && sdkInt >= 30;

  /// android sdk31-android 12-S
  static bool get isAndroidSdk31 => isAndroid && sdkInt >= 31;

  /// android sdk34-android 14-UpsideDownCake
  static bool get isAndroidSdk34 => isAndroid && sdkInt >= 34;

  /// android sdk35-android 15-VanillaIceCream
  static bool get isAndroidSdk35 => isAndroid && sdkInt >= 35;

  /// android sdk36-android 16-Baklava
  static bool get isAndroidSdk36 => isAndroid && sdkInt >= 36;

  /// Ios 12.0
  static bool get isIos12 => isIOS && sdkInt >= 12;

  /// Ios 14.0
  static bool get isIos14 => isIOS && sdkInt >= 14;

  /// Ios 15.0
  static bool get isIos15 => isIOS && sdkInt >= 15;

  /// Ios 16.0
  static bool get isIos16 => isIOS && sdkInt >= 16;

  /// Ios 17.0
  static bool get isIos17 => isIOS && sdkInt >= 17;

  /// Ios 18.0
  static bool get isIos18 => isIOS && sdkInt >= 18;

  /// 系统浏览器打开网页
  static Future<bool> openSystemBrowser(String url) async {
    if (!url.startsWith('http')) throw Exception('url must start with http');
    return await launchUrlString(url);
  }

  /// 打电话
  static Future<bool> callPhone(String phoneNumber) async {
    if (!phoneNumber.startsWith('tel:')) phoneNumber = 'tel:$phoneNumber';
    return await launchUrlString(phoneNumber);
  }

  /// 发短信
  static Future<bool> sendSms(String phoneNumber, [String body = '']) async {
    if (!phoneNumber.startsWith('sms:')) phoneNumber = 'sms:$phoneNumber';
    phoneNumber += Platform.isIOS ? '&' : '?';
    phoneNumber += 'body=$body';
    return await launchUrlString(phoneNumber);
  }

  /// 发送邮件
  static Future<bool> sendEmail(
    String email, [
    String subject = '',
    String body = '',
  ]) async {
    if (!email.contains('@')) throw Exception('email must contain @');
    email += '?subject=$subject&body=$body';
    return await launchUrlString(email);
  }

  /// 分享文本
  static Future<bool> shareText(String text) async {
    final params = ShareParams(text: text);
    return await SharePlus.instance
        .share(params)
        .then((v) => v.status == ShareResultStatus.success);
  }

  /// 分享文件
  static Future<bool> shareFile(String text, String filePath) async {
    final params = ShareParams(text: text, files: [XFile(filePath)]);
    return await SharePlus.instance
        .share(params)
        .then((v) => v.status == ShareResultStatus.success);
  }
}
