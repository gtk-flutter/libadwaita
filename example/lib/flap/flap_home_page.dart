import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:window_decorations/window_decorations.dart';

class FlapHomePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const FlapHomePage({Key? key, required this.themeNotifier}) : super(key: key);

  @override
  State<FlapHomePage> createState() => _FlapHomePageState();
}

class _FlapHomePageState extends State<FlapHomePage> {
  int _counter = 0;
  int? _currentIndex = 0;

  late ScrollController _scrollController;
  late ScrollController _scrollControllerOther;
  late FlapController _flapController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollControllerOther = ScrollController();
    _flapController = FlapController();

    _flapController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerOther.dispose();
    super.dispose();
  }

  void _incrementCounter() => setState(() => _counter++);

  void changeTheme() =>
      widget.themeNotifier.value = widget.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AdwHeaderBar.bitsdojo(
            appWindow: appWindow,
            windowDecor: windowDecor,
            start: Row(
              children: [
                AdwHeaderButton(
                  icon: Icon(
                      _flapController.isOpen ? Icons.close : Icons.view_sidebar,
                      size: 15),
                  onPressed: _flapController.toggle,
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
                        onTap: () => setState(() {
                          _counter = 0;
                          Navigator.of(context).pop();
                        }),
                        title: const Text('Reset Counter',
                            style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: AdwFlap(
              flapController: _flapController,
              flap: Drawer(
                child: AdwSidebar(
                  currentIndex: _currentIndex,
                  children: [
                    AdwSidebarItem(
                      leading: const Icon(Icons.countertops),
                      label: 'Counter',
                    ),
                    AdwSidebarItem(
                      leading: const Icon(Icons.list),
                      label: 'List View',
                    ),
                    AdwSidebarItem(
                      leading: const Icon(Icons.settings),
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
              index: _currentIndex,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                          'You have pushed the add button this many times:'),
                      Text('$_counter',
                          style: Theme.of(context).textTheme.headline4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: _incrementCounter,
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Center(
                    child: AdwClamp(
                      child: AdwPreferencesGroup(
                        children: List.generate(
                          15,
                          (index) => ListTile(
                            title: Text("Index $index"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  controller: _scrollControllerOther,
                  child: Center(
                    child: Column(
                      children: [
                        AdwClamp(
                          child: Column(
                            children: [
                              const AdwPreferencesGroup(
                                title: "Pages",
                                description:
                                    "Preferences are organized in pages, this example has the following pages:",
                                children: [
                                  AdwActionRow(
                                    title: "Layout",
                                  ),
                                  AdwActionRow(
                                    title: "Search",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const AdwPreferencesGroup(
                                title: "Groups",
                                description:
                                    "Preferences are grouped together, a group can have a title and a description. Descriptions will be wrapped if they are too long. This page has the following groups:",
                                children: [
                                  AdwActionRow(title: "An untitled group"),
                                  AdwActionRow(title: "Pages"),
                                  AdwActionRow(title: "Groups"),
                                  AdwActionRow(title: "Preferences"),
                                ],
                              ),
                              const SizedBox(height: 12),
                              AdwPreferencesGroup(
                                title: "Subpages",
                                description:
                                    "Preferences windows can have subpages.",
                                children: [
                                  AdwActionRow(
                                    title: "Go to a subpage",
                                    end: const Icon(Icons.chevron_right),
                                    onActivated: () => debugPrint("Hi"),
                                  ),
                                  const AdwActionRow(
                                    title: "Go to another subpage",
                                    end: Icon(Icons.chevron_right),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
