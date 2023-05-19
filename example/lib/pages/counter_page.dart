import 'package:example/pages/run_demo_screen.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.counter});

  final ValueNotifier<int> counter;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  void _incrementCounter() => widget.counter.value++;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: widget.counter,
      builder: (context, val, _) {
        return DemoScreen(
          title: 'Counter Example',
          description: 'You have pushed the add button this many times:',
          secondDescription: '$val',
          footer: AdwButton.pill(
            onPressed: _incrementCounter,
            child: const Text('Add'),
          ),
        );
      },
    );
  }
}
