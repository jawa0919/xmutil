import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;

class DemoPage extends StatefulWidget {
  static const String routeName = '/demo';
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var bg = Theme.of(context).colorScheme.primary;
    // bg = Colors.red;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _buildAppBar(context, bg),
      backgroundColor: bg,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Page Top'),
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...List.generate(100, (i) => Text(i.toString())),
              const Text('Page Bottom'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, Color backgroundColor) {
    var darkest = backgroundColor.computeLuminance() < 0.5;
    var br = darkest ? Brightness.dark : Brightness.light;
    var brIcon = darkest ? Brightness.light : Brightness.dark;
    var v = PlatformDispatcher.instance.views.last;
    var isFullScreen = v.display.size.height == v.physicalSize.height;
    var cl = isFullScreen ? Colors.transparent : backgroundColor;
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: br,
        statusBarIconBrightness: brIcon,
        systemStatusBarContrastEnforced: false,

        systemNavigationBarColor: cl,
        systemNavigationBarDividerColor: cl,
        systemNavigationBarIconBrightness: brIcon,
        systemNavigationBarContrastEnforced: false,
      ),
    );
  }
}
