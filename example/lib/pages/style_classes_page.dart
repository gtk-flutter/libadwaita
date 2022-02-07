import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class StyleClassesPage extends StatelessWidget {
  const StyleClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        child: Column(
          children: [
            const AdwButton(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text('Regular'),
            ),
            const AdwButton.pill(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text('Pill Button'),
            ),
            AdwButton.circular(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: const Icon(Icons.add),
            ),
            const AdwButton.flat(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: Text('Flat'),
            ),
            AdwButton(
              opaque: true,
              margin: const EdgeInsets.symmetric(vertical: 4),
              backgroundColor: AdwColors.blue.backgroundColor,
              textStyle: const TextStyle(color: Colors.white),
              child: const Text('Suggested'),
            ),
          ],
        ),
      ),
    );
  }
}
