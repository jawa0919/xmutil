import 'package:flutter/widgets.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class AppDialog {
  AppDialog._();
  static final TransitionBuilder builder = FlutterSmartDialog.init();
  static final NavigatorObserver observer = FlutterSmartDialog.observer;

  static void dismiss() {
    SmartDialog.dismiss();
  }

  static void showToast(String message) {
    SmartDialog.showToast(message);
  }

  static void showLoading() {
    SmartDialog.showLoading();
  }

  static void showLoadingText(String message) {
    SmartDialog.showLoading(msg: message);
  }

  static void showToastTop(String message) {
    SmartDialog.showToast(message, alignment: Alignment.topCenter);
  }

  static void showModel(String message) {}
  static void showDialog(String message) {}
  static void showBottomSheet(String message) {}
  static void showNotification(String message) {}
}
