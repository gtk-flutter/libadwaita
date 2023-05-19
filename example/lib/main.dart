import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:adwaita/adwaita.dart';
import 'package:collection/collection.dart';
import 'package:example/flap/flap_demo.dart';
import 'package:example/home_page.dart';
import 'package:example/view_switcher/view_switcher_demo.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

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
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    const windowOptions = WindowOptions(
      size: Size(1000, 600),
      minimumSize: Size(400, 450),
      skipTaskbar: false,
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.hidden,
      title: 'Libadwaita Example',
    );

    unawaited(
      windowManager.waitUntilReadyToShow(windowOptions, () async {
        if (Platform.isLinux || Platform.isMacOS) {
          await windowManager.setAsFrameless();
        }
        await windowManager.show();
        await windowManager.focus();
      }),
    );

    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          builder: (context, child) {
            final virtualWindowFrame = VirtualWindowFrameInit();

            return virtualWindowFrame(context, child);
          },
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
