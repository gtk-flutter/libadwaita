import 'package:example/pages/run_demo_screen.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreen(
      image: Image(
        image: AssetImage('assets/logo.png'),
        height: 130,
      ),
      title: 'Welcome to Adwaita flutter Demo.',
      description: 'This is a tour of the features this library has to offer.',
    );
  }
}
