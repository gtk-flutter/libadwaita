import 'dart:convert';

import 'package:adwaita/adwaita.dart';
import 'package:collection/collection.dart';
import 'package:example/flap/flap_demo.dart';
import 'package:example/home_page.dart';
import 'package:example/view_switcher/view_switcher_demo.dart';
import 'package:flutter/material.dart';

Future<void> main(List<String> args) async {
  if (args.firstOrNull == 'multi_window') {
    // final windowId = int.parse(args[1]);
    final argument = args[2].isEmpty
        ? <String, dynamic>{}
        : jsonDecode(args[2]) as Map<String, dynamic>;
    switch (argument['name']) {
      case 'flap':
        runApp(FlapDemo());
        break;
      case 'views':
        runApp(ViewSwitcherDemo());
        break;
    }
  } else {
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

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
          home: MyHomePage(themeNotifier: themeNotifier),
          themeMode: currentMode,
        );
      },
    );
  }
}
