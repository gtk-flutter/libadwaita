import 'package:adwaita/adwaita.dart';
import 'package:example/view_switcher/view_switcher_home_page.dart';
import 'package:flutter/material.dart';

class ViewSwitcherDemo extends StatelessWidget {
  ViewSwitcherDemo({super.key});

  final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

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
