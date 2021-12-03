import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:example/pages/counter_page.dart';
import 'package:example/pages/flap_page.dart';
import 'package:example/pages/lists_page.dart';
import 'package:example/pages/settings_page.dart';
import 'package:example/pages/view_switcher_page.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:window_decorations/window_decorations.dart';

class MyHomePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const MyHomePage({Key? key, required this.themeNotifier}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<int> counter = ValueNotifier(0);
  int? _currentIndex = 0;

  late ScrollController listController;
  late ScrollController settingsController;
  late FlapController _flapController;

  @override
  void initState() {
    super.initState();
    listController = ScrollController();
    settingsController = ScrollController();
    _flapController = FlapController();

    _flapController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    listController.dispose();
    settingsController.dispose();
    super.dispose();
  }

  void changeTheme() =>
      widget.themeNotifier.value = widget.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AdwHeaderBar.bitsdojo(
          appWindow: appWindow,
          windowDecor: windowDecor,
          start: Row(
            children: [
              Builder(
                builder: (context) {
                  return AdwHeaderButton(
                    icon: const Icon(Icons.view_sidebar, size: 15),
                    isActive: _flapController.isOpen,
                    onPressed: () {
                      _flapController.toggle();
                    },
                  );
                },
              ),
              AdwHeaderButton(
                icon: const Icon(Icons.nightlight_round, size: 15),
                onPressed: changeTheme,
              ),
            ],
          ),
          title: const Text("Libadwaita Demo"),
          end: Row(
            children: [
              AdwPopupMenu(
                body: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      onTap: () {
                        counter.value = 0;
                        Navigator.of(context).pop();
                      },
                      title: const Text(
                        'Reset Counter',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: AdwScaffold(
            flapController: _flapController,
            drawer: Drawer(
              child: AdwSidebar(
                currentIndex: _currentIndex,
                children: [
                  AdwSidebarItem(
                    label: 'Counter',
                  ),
                  AdwSidebarItem(
                    label: 'Lists',
                  ),
                  AdwSidebarItem(
                    label: 'Flap',
                  ),
                  AdwSidebarItem(
                    label: 'View Switcher',
                  ),
                  AdwSidebarItem(
                    label: 'Settings',
                  )
                ],
                onSelected: (index) {
                  setState(
                    () {
                      _currentIndex = index;
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
            body: AdwFlap(
              flapController: _flapController,
              foldPolicy: FoldPolicy.auto,
              flap: Drawer(
                child: AdwSidebar(
                  currentIndex: _currentIndex,
                  children: [
                    AdwSidebarItem(
                      label: 'Counter',
                    ),
                    AdwSidebarItem(
                      label: 'Lists',
                    ),
                    AdwSidebarItem(
                      label: 'Flap',
                    ),
                    AdwSidebarItem(
                      label: 'View Switcher',
                    ),
                    AdwSidebarItem(
                      label: 'Settings',
                    )
                  ],
                  onSelected: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              child: AdwViewStack(
                animationDuration: const Duration(milliseconds: 100),
                children: [
                  CounterPage(counter: counter),
                  const ListsPage(),
                  const FlapPage(),
                  const ViewSwitcherPage(),
                  const SettingsPage(),
                ],
                index: _currentIndex,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
