import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class ViewSwitcherHomePage extends StatefulWidget {
  const ViewSwitcherHomePage({Key? key}) : super(key: key);

  @override
  _ViewSwitcherHomePageState createState() => _ViewSwitcherHomePageState();
}

class _ViewSwitcherHomePageState extends State<ViewSwitcherHomePage> {
  ValueNotifier<int> index = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: index,
      builder: (context, int value, child) {
        return Column(
          children: [
            AdwHeaderBar.bitsdojo(
              appWindow: appWindow,
              title: AdwViewSwitcher(
                tabs: const [
                  ViewSwitcherData(
                    title: 'World',
                    icon: Icons.public,
                  ),
                  ViewSwitcherData(
                    title: 'Alarm',
                    icon: Icons.alarm,
                  ),
                  ViewSwitcherData(
                    title: 'Stopwatch',
                    icon: Icons.stop,
                    badge: '1',
                  ),
                  ViewSwitcherData(
                    title: 'Timer',
                    icon: Icons.timer,
                  ),
                ],
                onViewChanged: (idx) => index.value = idx,
                currentIndex: value,
              ),
            ),
            Expanded(
              child: AdwScaffold(
                body: AdwViewStack(
                  index: value,
                  children: const [
                    Center(
                      child: Text('World'),
                    ),
                    Center(
                      child: Text('Alarm'),
                    ),
                    Center(
                      child: Text('Stopwatch'),
                    ),
                    Center(
                      child: Text('Timer'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
