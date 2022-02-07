import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class ViewSwitcherPage extends StatelessWidget {
  const ViewSwitcherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        child: Column(
          children: [
            Text(
              'View Switcher',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            const Text(
              "Widgets to switch the window's view.",
            ),
            const SizedBox(height: 16),
            AdwButton.pill(
              onPressed: () async => await DesktopMultiWindow.createWindow(
                jsonEncode({'name': 'views'}),
              )
                ..setFrame(Offset.zero & const Size(1280, 720))
                ..center()
                ..setTitle('ViewSwitcher Example')
                ..show(),
              child: const Text('Run the demo'),
            ),
          ],
        ),
      ),
    );
  }
}
