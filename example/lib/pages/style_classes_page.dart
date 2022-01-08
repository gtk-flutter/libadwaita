import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class StyleClassesPage extends StatelessWidget {
  const StyleClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        center: true,
        child: Column(
          children: const [
            AdwButton(
              child: Text('Regular'),
            ),
            SizedBox(height: 4),
            AdwButton.pill(
              child: Text('Pill Button'),
            ),
            SizedBox(height: 4),
            AdwButton.circular(
              child: Icon(Icons.add),
            ),
            SizedBox(height: 4),
            AdwButton.flat(
              child: Text('Flat'),
            ),
          ],
        ),
      ),
    );
  }
}
