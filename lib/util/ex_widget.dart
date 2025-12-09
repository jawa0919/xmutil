import 'dart:ui' show PlatformDispatcher, FlutterView;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension OnTapContainer on Container {
  Widget onTap(GestureTapCallback? onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }
}

/// 在2000毫秒间内完成【连续点击10以上后再长按一次】进入全局hacker点击模式
extension OnHackerTapContainer on Container {
  static bool _hackerEnable = false;
  Widget onHackerTap(GestureTapCallback? onTap) {
    const hackerTargetCount = 10;
    const hackerTimeout = 2000;
    var hackerLastTime = 0;
    var hackerCount = 0;
    return GestureDetector(
      onTap: () {
        if (_hackerEnable) {
          onTap?.call();
          return;
        }
        var current = DateTime.now().millisecondsSinceEpoch;
        var travel = current - hackerLastTime;
        if (travel > 0 && travel < hackerTimeout) {
          hackerCount++;
        } else {
          hackerCount = 1;
        }
        hackerLastTime = current;
      },
      onLongPress: () {
        if (hackerCount >= hackerTargetCount) {
          _hackerEnable = true;
          onTap?.call();
        }
      },
      child: this,
    );
  }
}

extension OnTapText on Text {
  Widget onTap(GestureTapCallback? onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }
}

extension OnTapIcon on Icon {
  Widget onTap(GestureTapCallback? onTap) {
    return GestureDetector(onTap: onTap, child: this);
  }
}

extension ResetThemeData on ThemeData {
  /// 视图相关
  static FlutterView get _lastView => PlatformDispatcher.instance.views.last;

  /// 屏幕信息-多用于桌面端,移动端和屏幕和窗口一致
  static double get displayWidth => _lastView.display.size.width;
  static double get displayHeight => _lastView.display.size.height;

  /// 窗口信息
  static double get windowWidth => _lastView.physicalSize.width;
  static double get windowHeight => _lastView.physicalSize.height;
  static double get devicePixelRatio => _lastView.devicePixelRatio;

  /// 窗口遮罩
  static double get windowLeft => _lastView.viewPadding.left;
  static double get windowTop => _lastView.viewPadding.top;
  static double get windowRight => _lastView.viewPadding.right;
  static double get windowBottomTop => _lastView.viewPadding.bottom;

  /// 状态栏占位 可配合[Scaffold.extendBodyBehindAppBar]和[Scaffold.backgroundColor]
  ///
  /// 在android6.0(api23)(Marshmallow)后开发体验较好，可全透明
  static AppBar statusAppBar([Color backgroundColor = Colors.transparent]) {
    return AppBar(backgroundColor: backgroundColor, toolbarHeight: 0);
  }

  /// 导航栏占位 可配合[Scaffold.extendBody]和[Scaffold.backgroundColor]
  ///
  /// 在android8.1(api27)(Oreo)后开发体验较好
  static Widget navigationBar([Color? backgroundColor = Colors.transparent]) {
    return Builder(
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).padding.bottom,
          color: backgroundColor,
        );
      },
    );
  }

  FlutterView get _flutterView => PlatformDispatcher.instance.views.first;
  Brightness get toggleBrightness => Brightness.values[brightness.index ^ 1];
  Color get topColor => _flutterView.viewPadding.top == 0
      ? colorScheme.surface
      : Colors.transparent;
  Color get bottomColor => _flutterView.viewPadding.bottom == 0
      ? colorScheme.surface
      : Colors.transparent;

  ThemeData get reset => copyWith(
    scaffoldBackgroundColor: colorScheme.surface,
    appBarTheme: AppBarThemeData(
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: brightness,
        statusBarIconBrightness: toggleBrightness,
        systemStatusBarContrastEnforced: false,

        systemNavigationBarColor: bottomColor,
        systemNavigationBarDividerColor: bottomColor,
        systemNavigationBarIconBrightness: toggleBrightness,
        systemNavigationBarContrastEnforced: false,
      ),
    ),
    cardTheme: CardThemeData(
      color: colorScheme.surfaceContainerLow,
      shadowColor: Colors.transparent,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0),
      ),
    ),
  );
}
