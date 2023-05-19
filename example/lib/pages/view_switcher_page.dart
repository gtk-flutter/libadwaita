import 'package:example/pages/run_demo_screen.dart';
import 'package:flutter/material.dart';

class ViewSwitcherPage extends StatelessWidget {
  const ViewSwitcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScreen.runDemo(
      title: 'View Switcher',
      description: "Widgets to switch the window's view.",
      icon: Icons.table_chart,
      nextPageViewName: 'views',
    );
  }
}
