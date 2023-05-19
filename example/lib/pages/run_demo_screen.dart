// ignore_for_file: unawaited_futures

import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({
    super.key,
    required this.title,
    required this.description,
    this.secondDescription,
    this.image,
    this.footer,
  });

  DemoScreen.runDemo({
    super.key,
    required this.title,
    required this.description,
    this.secondDescription,
    required IconData icon,
    required String nextPageViewName,
  })  : image = Icon(
          icon,
          size: 130,
        ),
        footer = AdwButton.pill(
          onPressed: () async => await DesktopMultiWindow.createWindow(
            jsonEncode({'name': nextPageViewName}),
          )
            ..setFrame(Offset.zero & const Size(1280, 720))
            ..center()
            ..setTitle('$title Example')
            ..show(),
          child: const Text('Run the demo'),
        );

  final String title;
  final String description;
  final String? secondDescription;
  final Widget? image;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        child: Column(
          children: [
            if (image != null) ...[
              image!,
              const SizedBox(height: 30),
            ],
            Text(
              title,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 15),
            Text(description),
            if (secondDescription != null) ...[
              const SizedBox(height: 20),
              Text(
                secondDescription!,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
            if (footer != null) ...[
              SizedBox(height: secondDescription != null ? 20 : 40),
              footer!,
            ],
          ],
        ),
      ),
    );
  }
}
