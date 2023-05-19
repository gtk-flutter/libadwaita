import 'package:example/pages/run_demo_screen.dart';
import 'package:flutter/material.dart';

class FlapPage extends StatelessWidget {
  const FlapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScreen.runDemo(
      icon: Icons.view_sidebar_rounded,
      title: 'Flap',
      description: 'A widget showing a flap next or above the content.',
      nextPageViewName: 'flap',
    );
  }
}
