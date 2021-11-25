import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:multi_window/multi_window.dart';

class FlapPage extends StatefulWidget {
  const FlapPage({Key? key}) : super(key: key);

  @override
  _FlapPageState createState() => _FlapPageState();
}

class _FlapPageState extends State<FlapPage> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        center: true,
        controller: _controller,
        child: Column(
          children: [
            Text(
              "Flap",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            const Text(
              "A widget showing a flap next or above the content.",
            ),
            const SizedBox(height: 16),
            AdwTextButton(
              onPressed: () async {
                await MultiWindow.create(
                  'flap',
                );
              },
              child: const Text("Run the demo"),
            ),
          ],
        ),
      ),
    );
  }
}
