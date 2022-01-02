import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:multi_window/multi_window.dart';

class ViewSwitcherPage extends StatelessWidget {
  const ViewSwitcherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        center: true,
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
