import 'package:example/view_switcher/view_switcher_home_page.dart';
import 'package:flutter/material.dart';
import 'package:adwaita/adwaita.dart';

class ViewSwitcherDemo extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  ViewSwitcherDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          theme: AdwaitaThemeData.light(),
          darkTheme: AdwaitaThemeData.dark(),
          debugShowCheckedModeBanner: false,
          home: const ViewSwitcherHomePage(),
          themeMode: currentMode,
        );
      },
    );
  }
}
