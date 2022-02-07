// ignore_for_file: unawaited_futures

import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class FlapPage extends StatelessWidget {
  const FlapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        child: Column(
          children: [
            Text(
              'Flap',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            const Text(
              'A widget showing a flap next or above the content.',
            ),
            const SizedBox(height: 16),
            AdwButton.pill(
              onPressed: () async => await DesktopMultiWindow.createWindow(
                jsonEncode({'name': 'flap'}),
              )
                ..setFrame(Offset.zero & const Size(1280, 720))
                ..center()
                ..setTitle('Flap Example')
                ..show(),
              child: const Text('Run the demo'),
            ),
          ],
        ),
      ),
    );
  }
}
