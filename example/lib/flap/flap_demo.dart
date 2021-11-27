import 'flap_home_page.dart';
import 'package:flutter/material.dart';
import 'package:adwaita/adwaita.dart' as adwaita;

class FlapDemo extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  FlapDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          theme: adwaita.lightTheme,
          darkTheme: adwaita.darkTheme,
          debugShowCheckedModeBanner: false,
          home: FlapHomePage(themeNotifier: themeNotifier),
          themeMode: currentMode,
        );
      },
    );
  }
}
