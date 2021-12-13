import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Image(
          image: AssetImage('assets/logo.png'),
          height: 150,
        ),
        Text(
          "Welcome to Adwaita flutter Demo.",
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Text(
          "This is a tour of the features this library has to offer.",
        ),
      ]
          .map((e) => Padding(
                child: e,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ))
          .toList(),
    );
  }
}
