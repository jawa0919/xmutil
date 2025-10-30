import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String routeName = '/main';
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final appLinks = AppLinks();
  StreamSubscription<Uri>? linkSub;

  @override
  void initState() {
    super.initState();
    debugPrint('main_page.dart~initState: ');
    linkSub = appLinks.uriLinkStream.listen((uri) {
      debugPrint('main_page.dart~initState: $uri');
    });
  }

  @override
  void dispose() {
    linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('小明工具箱')),
      body: SafeArea(
        child: Column(
          children: [
            const Placeholder(),
            SizedBox(height: 20),
            StreamBuilder<Uri>(
              stream: appLinks.uriLinkStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('${snapshot.data}');
                } else {
                  return const Text('No link yet');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
