import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:multi_window/multi_window.dart';

class StyleClassesPage extends StatelessWidget {
  const StyleClassesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AdwClamp.scrollable(
        center: true,
        child: Column(
          children: [
            AdwButton(
              child: Text('Pill Button'),
              onPressed: () => null,
            ),
            AdwButton.pill(
              child: Text('Pill Button'),
              onPressed: () => null,
            ),
            AdwButton.circular(
              child: Icon(Icons.add),
              onPressed: () => null,
            ),
            AdwButton.flat(
              child: Text('Pill Button'),
              onPressed: () => null,
            ),
            AdwButton.outline(
              child: Text('Pill Button'),
              onPressed: () => null,
            ),
            Icon(
              Icons.brush,
              size: 128,
              color: Theme.of(context).iconTheme.color!.withOpacity(0.48),
            ),
            const SizedBox(height: 10),
            Text(
              "Style Classes",
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 10),
            const Text(
              "Various widget styles available for use.",
            ),
            const SizedBox(height: 16),
            AdwTextButton(
              onPressed: () async => await MultiWindow.create(
                'style_classes',
              ),
              child: const Text("Run the demo"),
            ),
          ],
        ),
      ),
    );
  }
}
