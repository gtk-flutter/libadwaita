import 'package:example/pages/run_demo_screen.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AboutDialogPage extends StatelessWidget {
  const AboutDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoScreen(
      image: const Icon(
        Icons.view_sidebar_rounded,
        size: 130,
      ),
      title: 'About Dialog',
      description: 'Something something',
      footer: AdwButton.pill(
          child: const Text('Run the demo'),
        onPressed: () {
          showDialog<Widget>(
            context: context,
            builder: (context) => const AdwAboutWindow(
              appIcon: Icon(Icons.mp),
            ),
          );
        },
      ),
    );
  }
}
