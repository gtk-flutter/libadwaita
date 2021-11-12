import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) => MaterialApp(
          darkTheme: adwaitaDark,
          theme: adwaitaLight,
          debugShowCheckedModeBanner: false,
          home: MyHomePage(themeNotifier: themeNotifier),
          themeMode: currentMode),
    );
  }
}
