class AppConst {
  AppConst._();
  static const bool isProduct = bool.fromEnvironment('dart.vm.product');
  static const bool isWeb = bool.fromEnvironment('dart.library.js_util');
  static const bool isWasm = bool.fromEnvironment('dart.tool.dart2wasm');

  // 适合平板的尺寸
  static const designWidth = 1366.0;
  static const designHeight = 1024.0;

  // // 适合手机的尺寸
  // static const designWidth = 750.0;
  // static const designHeight = 1334.0;

  // App Store id
  static const String appStoreId = '';
  // 用户协议url
  static const String agreementUrl = 'https://flutter.cn';
  // 隐私政策url
  static const String privacyUrl = 'https://flutter.cn';
  // icp备案号
  static const String icpNumber = '';
  // icp备案号查询链接
  static const String icpQueryUrl = 'https://beian.miit.gov.cn/';
  // 版权标志
  static const String copyrightCode = 'Copyright © 2006-2025 flutter公司';
  // 获取App Store更新信息
  static const String appStoreLookup = 'https://itunes.apple.com/cn/lookup?id=';

  /// 服务器列表
  static const serverInfoList = [
    {
      'env': 'release',
      'apiHost': 'https://mcai.duibu.cn',
      'h5Host': 'https://flutter.cn',
    },
    {
      'env': 'test',
      'apiHost': 'https://tmcai.duibu.cn',
      'h5Host': 'https://flutter.cn',
    },
    {
      'env': 'debug',
      'apiHost': 'https://dmcai.duibu.cn',
      'h5Host': 'https://flutter.cn',
    },
    {'env': 'custom', 'apiHost': null, 'h5Host': null},

    /// 本地测试环境_黄威
    {
      'env': 'local_黄威',
      'apiHost': 'http://10.41.2.6:33003',
      // 'h5Host': 'https://flutter.cn',
      'h5Host': 'https://vant-ui.github.io/vant',
    },
  ];
}
