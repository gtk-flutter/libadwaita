import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:multi_window/multi_window.dart';

class ViewSwitcherPage extends StatefulWidget {
  const ViewSwitcherPage({Key? key}) : super(key: key);

  @override
  _ViewSwitcherPageState createState() => _ViewSwitcherPageState();
}

class _ViewSwitcherPageState extends State<ViewSwitcherPage> {
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
              "View Switcher",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            const Text(
              "Widgets to switch the window's view.",
            ),
            const SizedBox(height: 16),
            AdwTextButton(
              onPressed: () async {
                await MultiWindow.create(
                  'view_switcher',
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
