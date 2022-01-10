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
              child: Text('Regular'),
            ),
            const SizedBox(height: 4),
            const AdwButton.pill(
              child: Text('Pill Button'),
            ),
            const SizedBox(height: 4),
            const AdwButton.circular(
              child: Icon(Icons.add),
            ),
            const SizedBox(height: 4),
            const AdwButton.flat(
              child: Text('Flat'),
            ),
            AdwButton(
              opaque: true,
              backgroundColor: AdwAvatarColors.blue.backgroundColor,
              child: const Text('Suggested'),
            ),
          ],
        ),
      ),
    );
  }
}
