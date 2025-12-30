import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:signals/signals.dart';

import '../app_import.dart';

extension LanguageString on String {
  String get tr => LanguageStore.to.keys.value?[this] ?? this;
  String trArgs([List<String> args = const []]) {
    var key = tr;
    if (args.isNotEmpty) {
      for (final arg in args) {
        key = key.replaceFirst(RegExp(r'%s'), arg.toString());
      }
    }
    return key;
  }
}

class LanguageStore {
  static List<LocalizationsDelegate> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
  static List<Locale> supportedLocales = [
    const Locale('zh', 'CN'),
    const Locale('en', 'US'),
    const Locale('ja', 'JP'),
  ];
  static Map<Locale, Map<String, String>> languageMap = {
    const Locale('zh', 'CN'): {...CommonLanguage.zh},
    const Locale('en', 'US'): {...CommonLanguage.en},
    const Locale('ja', 'JP'): {...CommonLanguage.ja},
  };
  static final LanguageStore to = _instance;
  static final LanguageStore _instance = LanguageStore._internal();
  factory LanguageStore() => _instance;

  final _languageIndex = signal(0);
  late final locale = computed(() => supportedLocales[_languageIndex.value]);
  late final keys = computed(() => languageMap[locale.value]);

  LanguageStore._internal() {
    debugPrint('language_store.dart~_internal: ');
    var language = chooseLanguage();
    var index = supportedLocales.indexWhere((e) => e == language);
    if (index == -1) index = 0;
    _languageIndex.value = GlobalUtil.pref.getInt('_languageIndex') ?? index;
  }

  Locale chooseLanguage() {
    debugPrint('language_store.dart~supportedLocales: $supportedLocales');
    final platformLocales = PlatformDispatcher.instance.locales;
    debugPrint('language_store.dart~platformLocales: $platformLocales');
    for (var l in supportedLocales) {
      for (var pl in platformLocales) {
        if (pl.languageCode == l.languageCode) return l;
      }
    }
    return supportedLocales.first;
  }

  void saveLanguageIndex(int index) {
    if (index < 0) return;
    if (index >= supportedLocales.length) return;
    _languageIndex.value = index;
    GlobalUtil.pref.setInt('_languageIndex', _languageIndex.value);
  }

  void toggleLanguage() {
    saveLanguageIndex(_languageIndex.value == 0 ? 1 : 0);
  }

  void resetLanguage() {
    var language = chooseLanguage();
    var index = supportedLocales.indexWhere((e) => e == language);
    if (index == -1) index = 0;
    saveLanguageIndex(index);
  }
}

class CommonLanguage {
  static final zh = {
    'nav.home': '首页',
    'nav.profile': '个人中心',
    'nav.settings': '设置',
    'user.name': '姓名',
    'user.account': '账号',
    'user.email': '邮箱',
    'user.phone': '手机号码',
    'action.save': '保存',
    'action.cancel': '取消',
    'action.delete': '删除',
    'action.confirm': '确认',
    'action.done': '完成',
    'message.loading': '加载中...',
    'message.success': '操作成功',
    'message.error': '操作失败',
    'validation.required': '此字段为必填项',
    'validation.email': '请输入有效的邮箱地址',
    'validation.phone': '请输入有效的手机号码',
    'validation.code': '请输入有效的验证码',
    'error.network': '网络连接失败',
    'error.server': '服务器错误',
    'error.unknown': '未知错误',
  };
  static final en = {
    'nav.home': 'Home',
    'nav.profile': 'Profile',
    'nav.settings': 'Settings',
    'user.account': 'Account',
    'user.name': 'Name',
    'user.email': 'Email',
    'user.phone': 'Phone',
    'user.please.enter': 'Please enter',
    'action.save': 'Save',
    'action.cancel': 'Cancel',
    'action.delete': 'Delete',
    'action.confirm': 'Confirm',
    'action.done': 'Done',
    'message.loading': 'Loading...',
    'message.success': 'Success',
    'message.error': 'Error',
    'validation.required': 'This field is required',
    'validation.email': 'Please enter a valid email',
    'validation.phone': 'Please enter a valid phone number',
    'validation.code': 'Please enter a valid verification code',
    'error.network': 'Network connection failed',
    'error.server': 'Server error',
    'error.unknown': 'Unknown error',
  };
  static final ja = {
    'nav.home': 'ホーム',
    'nav.profile': 'プロフィール',
    'nav.settings': '設定',
    'user.account': 'アカウント',
    'user.name': '名前',
    'user.email': 'メール',
    'user.phone': '電話番号',
    'user.please.enter': '入力してください',
    'action.save': '保存',
    'action.cancel': 'キャンセル',
    'action.delete': '削除',
    'action.confirm': '確認',
    'action.done': '終了',
    'message.loading': '読み込み中...',
    'message.success': '成功',
    'message.error': 'エラー',
    'validation.required': 'このフィールドは必須です',
    'validation.email': '有効なメールアドレスを入力してください',
    'validation.phone': '有効な電話番号を入力してください',
    'validation.code': '有効な認証を入力してください',
    'error.network': 'ネットワーク接続に失敗しました',
    'error.server': 'サーバーエラー',
    'error.unknown': '不明なエラー',
  };
}
