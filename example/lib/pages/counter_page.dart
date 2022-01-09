import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({Key? key, required this.counter}) : super(key: key);

  final ValueNotifier<int> counter;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  void _incrementCounter() => widget.counter.value++;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        child: ValueListenableBuilder(
          valueListenable: widget.counter,
          builder: (_, value, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You have pushed the add button this many times:'),
                Text(
                  '$value',
                  style: Theme.of(context).textTheme.headline4,
                ),
                AdwButton.pill(
                  onPressed: _incrementCounter,
                  child: const Text('Add'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
