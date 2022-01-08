import 'package:example/flap/flap_demo.dart';
import 'package:example/view_switcher/view_switcher_demo.dart';
import 'package:multi_window/multi_widget.dart';
import 'package:multi_window/multi_window.dart';

import 'home_page.dart';
import 'package:flutter/material.dart';
import 'package:adwaita/adwaita.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();

  MultiWindow.init(args);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
            theme: AdwaitaThemeData.light(),
            darkTheme: AdwaitaThemeData.dark(),
            debugShowCheckedModeBanner: false,
            home: MultiWidget(
              {
                'flap': FlapDemo(),
                'view_switcher': ViewSwitcherDemo(),
              },
              fallback: MyHomePage(themeNotifier: themeNotifier),
            ),
            themeMode: currentMode);
      },
    );
  }
}
