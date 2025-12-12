import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show DeviceOrientation, SystemChrome;

import 'app.dart';
import 'app_import.dart';

void main(args) async {
  debugPrint('main.dart~running: $args');
  // ignore: unused_local_variable
  final wfb = WidgetsFlutterBinding.ensureInitialized();
  // wfb.deferFirstFrame();
  // wfb.resetFirstFrameSent();
  await GlobalUtil.init();
  await _initSystemChrome();
  await _printDebugMessage();
  runApp(const App());
}

Future<void> _initSystemChrome() async {
  if (GlobalUtil.isAndroid || GlobalUtil.isIOS) {
    List<DeviceOrientation> devOri = [];
    // // 平板设备横屏
    // devOri = [DeviceOrientation.landscapeLeft];
    // 手机设备竖屏
    devOri = [DeviceOrientation.portraitUp];
    await SystemChrome.setPreferredOrientations(devOri);
  }
}

Future<void> _printDebugMessage() async {
  if (!GlobalUtil.isProduct) {
    debugPrint('..._printDebugMessage...');
    debugPrint('tempDir: ${GlobalUtil.tempDir}');
    debugPrint('docsDir: ${GlobalUtil.docsDir}');

    debugPrint('systemVersion: ${GlobalUtil.systemVersion}');
    debugPrint('brand: ${GlobalUtil.brand}');
    debugPrint('model: ${GlobalUtil.model}');

    debugPrint('appName: ${GlobalUtil.appName}');
    debugPrint('appId: ${GlobalUtil.appId}');
    debugPrint('buildVersion: ${GlobalUtil.buildVersion}');
    debugPrint('buildNumber: ${GlobalUtil.buildNumber}');
    debugPrint('buildSignature: ${GlobalUtil.buildSignature}');
  }
}
