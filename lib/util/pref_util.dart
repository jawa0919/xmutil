import 'dart:io' show Platform;
import 'dart:ui' show ViewPadding, PlatformDispatcher;

import 'package:flutter/services.dart' show SystemUiMode, SystemChrome;
import 'package:flutter/widgets.dart' show WidgetsFlutterBinding, debugPrint;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  PrefUtil._();

  // 本地存储信息
  static late SharedPreferences pref;
  static late String docsDir;
  static late String tempDir;

  /// 设备信息
  static Map<String, dynamic>? _deviceInfo;
  static get _sdkInt =>
      _deviceInfo?['version']?['sdkInt']?.toString() ??
      _deviceInfo?['systemVersion']?.toString() ??
      '0';
  static double get systemVersion => double.parse(_sdkInt);
  static get _brand => _deviceInfo?['brand'] ?? _deviceInfo?['model'] ?? '';
  static String get brand => _brand.toString().toLowerCase();
  static get _model => _deviceInfo?['model'] ?? _deviceInfo?['modelName'] ?? '';
  static String get model => _model.toString().toLowerCase();

  /// 应用信息
  static PackageInfo? _packageInfo;
  static String get appName => _packageInfo?.appName ?? '';
  static String get appId => _packageInfo?.packageName ?? '';
  static String get buildVersion => _packageInfo?.version ?? '';
  static String get buildNumber => _packageInfo?.buildNumber ?? '';
  static String get buildSignature => _packageInfo?.buildSignature ?? '';
  static String get appUserAgent => '$appId($buildVersion;$buildNumber)';

  /// 屏幕信息
  static final Map<String, dynamic> _screenInfo = {};
  static double get width => _screenInfo['width'] ?? 0;
  static double get height => _screenInfo['height'] ?? 0;
  static double get devicePixelRatio => _screenInfo['devicePixelRatio'] ?? 0;
  static ViewPadding get viewPadding =>
      _screenInfo['viewPadding'] ?? ViewPadding.zero;

  /// 初始化
  static Future<SharedPreferences> init() async {
    debugPrint('pref_util.dart~init: ');
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
    debugPrint('pref_util.dart~docsDir: $docsDir');
    debugPrint('pref_util.dart~tempDir: $tempDir');
    _deviceInfo ??= (await DeviceInfoPlugin().deviceInfo).data;
    debugPrint('pref_util.dart~_deviceInfo: $_deviceInfo');
    _packageInfo ??= await PackageInfo.fromPlatform();
    debugPrint('pref_util.dart~_packageInfo: $_packageInfo');
    var firstView = PlatformDispatcher.instance.views.last;
    _screenInfo.addAll({'width': firstView.physicalSize.width});
    _screenInfo.addAll({'height': firstView.physicalSize.height});
    _screenInfo.addAll({'devicePixelRatio': firstView.devicePixelRatio});
    _screenInfo.addAll({'viewPadding': firstView.viewPadding});
    debugPrint('pref_util.dart~_screenInfo: $_screenInfo');
    return pref;
  }
}

extension PlatformVersion on PrefUtil {
  /// android sdk21-android 5.0-Lollipop
  static bool get isAndroidSdk21 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 21;

  /// android sdk24-android 7.0-Nougat
  static bool get isAndroidSdk24 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 24;

  /// android sdk27-android 8.1-Oreo
  static bool get isAndroidSdk27 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 27;

  /// android sdk28-android 9-Pie
  static bool get isAndroidSdk28 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 28;

  /// android sdk29-android 10-Q
  static bool get isAndroidSdk29 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 29;

  /// android sdk30-android 11-R
  static bool get isAndroidSdk30 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 30;

  /// android sdk31-android 12-S
  static bool get isAndroidSdk31 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 31;

  /// android sdk34-android 14-UpsideDownCake
  static bool get isAndroidSdk34 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 34;

  /// android sdk35-android 15-VanillaIceCream
  static bool get isAndroidSdk35 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 35;

  /// android sdk36-android 16-Baklava
  static bool get isAndroidSdk36 =>
      Platform.isAndroid && PrefUtil.systemVersion >= 36;

  /// Ios 12.0
  static bool get isIos12 => Platform.isIOS && PrefUtil.systemVersion >= 12;

  /// Ios 14.0
  static bool get isIos14 => Platform.isIOS && PrefUtil.systemVersion >= 14;

  /// Ios 16.0
  static bool get isIos16 => Platform.isIOS && PrefUtil.systemVersion >= 16;

  /// Ios 18.0
  static bool get isIos18 => Platform.isIOS && PrefUtil.systemVersion >= 18;
}
