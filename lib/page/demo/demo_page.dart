import 'package:flutter/material.dart';

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
    if (_counter.isEven) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var bg = Theme.of(context).colorScheme.primary;
    // bg = Colors.red;
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Demo Page'),
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
}
