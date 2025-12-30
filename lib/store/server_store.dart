import '../app_import.dart';

class ServerStore {
  /// 服务器列表
  static const serverInfoList = [
    {
      'env': 'prod',
      'apiHost': 'https://api.flutter.cn',
      'h5Host': 'https://flutter.cn',
    },
    {
      'env': 'uat',
      'apiHost': 'https://uat-api.flutter.cn',
      'h5Host': 'https://flutter.cn',
    },
    {
      'env': 'dev',
      'apiHost': 'https://dev-api.flutter.cn',
      'h5Host': 'https://flutter.cn',
    },
    {'env': 'custom', 'apiHost': null, 'h5Host': null},
  ];

  static final ServerStore to = _instance;
  static final ServerStore _instance = ServerStore._internal();
  factory ServerStore() => _instance;

  ServerStore._internal() {
    debugPrint('server_store.dart~_internal: ');
    _serverEnv = GlobalUtil.pref.getString('_serverEnv') ?? 'dev';
    if (_serverEnv == 'custom') {
      _serverInfo = {
        'env': 'custom',
        'apiHost': GlobalUtil.pref.getString('custom_apiHost'),
        'h5Host': GlobalUtil.pref.getString('custom_h5Host'),
      };
    } else {
      _serverInfo = serverInfoList.firstWhere((e) => e['env'] == _serverEnv);
    }

    checkUpdateEpoch = GlobalUtil.pref.getInt('checkUpdateEpoch') ?? 0;
  }

  /// 服务器信息
  var _serverEnv = 'dev';
  var _serverInfo = <String, dynamic>{};
  String get env => _serverEnv;
  String get apiHost => _serverInfo['apiHost']?.toString() ?? '';
  String get h5Host => _serverInfo['h5Host']?.toString() ?? '';

  /// 更新信息
  int checkUpdateEpoch = 0;
  bool get isFirstOpen => !GlobalUtil.pref.containsKey('checkUpdateEpoch');

  Future<void> saveServerInfo(Map<String, dynamic> val) async {
    await GlobalUtil.pref.setString('_serverEnv', val['env']);
    _serverEnv = val['env'];
    _serverInfo = val;
    if (val['env'] == 'custom') {
      await GlobalUtil.pref.setString('custom_apiHost', val['apiHost']);
      await GlobalUtil.pref.setString('custom_h5Host', val['h5Host']);
    }
  }
}
