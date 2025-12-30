import 'package:flutter/material.dart';

import '../app_import.dart';
import 'jump_third_app_page.dart';
import 'storage_show_page.dart';
import 'theme_color_show_page.dart';

class DebugPage extends StatefulWidget {
  static const String routeName = '/debug';
  const DebugPage({super.key});

  static void start(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DebugPage()),
    );
  }

  @override
  State<DebugPage> createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  int _counter = 0;

  void _incrementCounter() {
    _counter++;
    if (_counter.isEven) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var bg = Theme.of(context).colorScheme.primary;
    bg = Theme.of(context).colorScheme.surface;
    // bg = Colors.red;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Debug Page'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Page Top'),
              ...List.generate(26, (i) => Text(String.fromCharCode(65 + i))),
              const Text('You have pushed the button this many times:'),
              Container(
                margin: const EdgeInsets.all(16),
                child: Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              TextButton(
                child: const Text('存储展示'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StorageShowPage(),
                    ),
                  );
                },
              ),
              TextButton(
                child: const Text('主题颜色'),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ThemeColorShowPage(),
                    ),
                  );
                },
              ),
              TextButton(
                child: const Text('第三方跳转'),
                onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const JumpThirdAppPage(),
                    ),
                  );
                },
              ),
              TextButton(child: const Text('二维码扫描'), onPressed: () async {}),
              TextButton(child: const Text('消息推送'), onPressed: () async {}),
              TextButton(child: const Text('文件上传测试'), onPressed: () async {}),
              TextButton(child: const Text('文件下载测试'), onPressed: () async {}),
              TextButton(child: const Text('安全退出'), onPressed: () async {}),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text('showToast'),
                      onPressed: () async {
                        ExDialog.showToast('hello world');
                      },
                    ),
                    TextButton(
                      child: const Text('showToastCenter'),
                      onPressed: () async {
                        ExDialog.showToastCenter('hello world center');
                      },
                    ),
                    TextButton(
                      child: const Text('showToastTop'),
                      onPressed: () async {
                        ExDialog.showToastTop('hello world top');
                      },
                    ),
                    TextButton(
                      child: const Text('showLoading'),
                      onPressed: () async {
                        ExDialog.showLoading();
                        await Future.delayed(const Duration(seconds: 2));
                        ExDialog.dismiss();
                      },
                    ),
                    TextButton(
                      child: const Text('showDialog'),
                      onPressed: () async {
                        await ExDialog.showDialog(
                          Text('确认删除吗？'),
                          title: '提示',
                          confirmText: '确定',
                          cancelText: '取消',
                          beforeClose: (buttonText) async {
                            if (buttonText == '确定') {
                              await Future.delayed(const Duration(seconds: 2));
                              return true;
                            }
                            return false;
                          },
                        ).then((value) {
                          if (value == '确定') {
                            ExDialog.showToast('删除成功');
                          } else {
                            ExDialog.showToast('删除取消');
                          }
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('showBottomDialog'),
                      onPressed: () async {
                        await ExDialog.showBottomDialog(
                          Column(
                            children: [
                              Text('确认删除吗？'),
                              Text('取消').onTap(() => ExDialog.dismiss()),
                              Text(
                                '确认',
                              ).onTap(() => ExDialog.dismiss(result: '确定')),
                            ],
                          ),
                        ).then((value) {
                          if (value == '确定') {
                            ExDialog.showToast('删除成功');
                          } else {
                            ExDialog.showToast('删除取消');
                          }
                        });
                      },
                    ),
                    TextButton(
                      child: const Text('showConfirm'),
                      onPressed: () async {
                        await ExDialog.showConfirm(
                          '确认删除吗？',
                          title: '提示',
                          confirmText: '确定',
                          cancelText: '取消',
                          beforeClose: (buttonText) async {
                            if (buttonText == '确定') {
                              await Future.delayed(const Duration(seconds: 2));
                              return true;
                            }
                            return true;
                          },
                        ).then((value) {
                          if (value == '确定') {
                            ExDialog.showToast('删除成功');
                          } else {
                            ExDialog.showToast('删除取消');
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
              ...List.generate(50, (i) => Text(i.toString())),
              TextField(decoration: InputDecoration(labelText: '请输入')),
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
}
