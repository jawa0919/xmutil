import 'package:flutter/material.dart';

import './app_import.dart';
import 'page/debug/demo_page.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ).reset,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.deepPurple,
        ),
      ).reset,
      home: const DemoPage(),
      // themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      themeMode: ThemeMode.system,
    );
  }
}
