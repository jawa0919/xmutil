import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:signals/signals.dart';

import '../app_import.dart';

class ThemeStore {
  /// 主题色
  static const primaryColor = Color(0xFF469F68);

  /// 次级主题色
  static const secondaryColor = Color(0xFF23593B);

  /// 错误色
  static const errorColor = Color(0xFFD54941);

  /// 背景色
  static const surfaceColor = Color(0xFFF3F3F3);

  /// 主字体颜色
  static const onSurfaceColor = Color.fromRGBO(0, 0, 0, 0.9);

  /// 次级背景色
  static const surfaceContainerColor = Color(0xFFFFFFFF);

  /// 次级主字体颜色
  static const onSecondaryContainerColor = Color.fromRGBO(0, 0, 0, 0.6);

  /// 半透明背景色
  static const scrimColor = Color.fromRGBO(0, 0, 0, 0.26);

  /// 轮廓色
  static const outlineColor = Color(0xFFC5C5C5);

  /// 轮廓色变体
  static const outlineVariantColor = Color(0xFFDCDCDC);

  /// 真白颜色
  static const trueBlack = Color(0xFF000000);

  /// 真黑颜色
  static const trueWhite = Color(0xFFFFFFFF);

  /// 真透明颜色
  static const trueTransparent = Color(0x00000000);

  static final _colorScheme = ColorScheme.fromSeed(seedColor: primaryColor)
      .copyWith(
        primary: primaryColor,

        secondary: secondaryColor,

        error: errorColor,

        surface: surfaceColor,
        onSurface: onSurfaceColor,

        surfaceContainerHighest: surfaceColor,
        surfaceContainerHigh: surfaceColor,
        surfaceContainer: surfaceContainerColor,
        surfaceContainerLow: surfaceContainerColor,
        surfaceContainerLowest: surfaceContainerColor,
        onSurfaceVariant: onSecondaryContainerColor,

        scrim: scrimColor,

        outline: outlineColor,
        outlineVariant: outlineVariantColor,
      );

  static List<ThemeData> get lightList => [
    ThemeData(colorScheme: _colorScheme).reset,
  ];
  static List<ThemeData> get darkList => [ThemeData.dark().reset];

  static final ThemeStore to = _instance;
  static final ThemeStore _instance = ThemeStore._internal();
  factory ThemeStore() => _instance;

  ThemeStore._internal() {
    debugPrint('theme_store.dart~onInit: ');
    _lightThemeIndex.value = GlobalUtil.pref.getInt('_lightThemeIndex') ?? 0;
    _darkThemeIndex.value = GlobalUtil.pref.getInt('_darkThemeIndex') ?? 0;
    themeModeIndex.value = GlobalUtil.pref.getInt('_themeModeIndex') ?? 1;
  }

  final _lightThemeIndex = signal(0);
  late final lightTheme = computed(() => lightList[_lightThemeIndex.value]);
  final _darkThemeIndex = signal(0);
  late final darkTheme = computed(() => darkList[_darkThemeIndex.value]);
  final themeModeIndex = signal(1);
  late final themeMode = computed(() => ThemeMode.values[themeModeIndex.value]);
  late final isDark = computed(() {
    if (themeMode.value == ThemeMode.system) {
      return SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark;
    }
    return themeMode.value == ThemeMode.dark;
  });
  late final _theme = computed(() {
    return isDark.value ? darkTheme.value : lightTheme.value;
  });
  static ColorScheme get color => to._theme.value.colorScheme;

  void toggleTheme() {
    if (themeModeIndex.value == 1) {
      themeModeIndex.value = 2;
    } else if (themeModeIndex.value == 2) {
      themeModeIndex.value = 1;
    } else {
      switch (SchedulerBinding.instance.platformDispatcher.platformBrightness) {
        case Brightness.light:
          themeModeIndex.value = 2;
          break;
        case Brightness.dark:
          themeModeIndex.value = 1;
          break;
      }
    }
  }

  void saveThemeMode(ThemeMode themeMode) {
    themeModeIndex.value = themeMode.index;
  }
}
