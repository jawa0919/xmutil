import 'package:flutter/material.dart';

import 'app.dart';
import 'app_import.dart';

void main(args) async {
  debugPrint('main.dart~running: $args');
  // ignore: unused_local_variable
  final wfb = WidgetsFlutterBinding.ensureInitialized();
  // wfb.deferFirstFrame();
  // wfb.resetFirstFrameSent();
  await PrefUtil.init();
  runApp(const App());
}
