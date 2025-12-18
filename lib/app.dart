import 'package:flutter/material.dart';

import 'app_import.dart';
import 'debug/debug_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: Colors.deepPurple,
        ),
      ).reset,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepPurple,
        ),
      ).reset,
      themeMode: ThemeMode.system,

      navigatorObservers: [ExDialog.observer],
      builder: (context, child) => ExDialog.builder(context, child),

      home: const DebugPage(),
    );
  }
}
