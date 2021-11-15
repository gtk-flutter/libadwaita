import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:adwaita/adwaita.dart' as adwaita;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
              theme: adwaita.lightTheme,
              darkTheme: adwaita.darkTheme,
              debugShowCheckedModeBanner: false,
              home: MyHomePage(themeNotifier: themeNotifier),
              themeMode: currentMode);
        });
  }
}
