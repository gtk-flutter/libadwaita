import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:multi_window/multi_window.dart';
import 'package:window_decorations/window_decorations.dart';

class MyHomePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const MyHomePage({Key? key, required this.themeNotifier}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
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
                  icon: const Icon(Icons.view_sidebar, size: 15),
                  isActive: _flapController.isOpen,
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
                      label: 'Counter',
                    ),
                    AdwSidebarItem(
                      label: 'Lists',
                    ),
                    AdwSidebarItem(
                      label: 'Flap',
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
              index: _currentIndex,
              children: [
                Center(
                  child: AdwClamp.scrollable(
                    center: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'You have pushed the add button this many times:'),
                        Text('$_counter',
                            style: Theme.of(context).textTheme.headline4),
                        AdwTextButton(
                          onPressed: _incrementCounter,
                          child: const Text("Add"),
                        ),
                      ],
                    ),
                  ),
                ),
                AdwClamp.scrollable(
                  center: true,
                  controller: listController,
                  child: AdwPreferencesGroup(
                    children: List.generate(
                      15,
                      (index) => ListTile(
                        title: Text("Index $index"),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: AdwClamp.scrollable(
                    center: true,
                    controller: listController,
                    child: Column(
                      children: [
                        Text(
                          "Flap",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "A widget showing a flap next or above the content.",
                        ),
                        const SizedBox(height: 16),
                        AdwTextButton(
                          onPressed: () async {
                            await MultiWindow.create(
                              'flap',
                            );
                          },
                          child: const Text("Run the demo"),
                        ),
                      ],
                    ),
                  ),
                ),
                AdwClamp.scrollable(
                  center: true,
                  controller: settingsController,
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
                        description: "Preferences windows can have subpages.",
                        children: [
                          AdwActionRow(
                            title: "Go to a subpage",
                            end: const Icon(Icons.chevron_right),
                            onActivated: () => print("Hi"),
                          ),
                          const AdwActionRow(
                            title: "Go to another subpage",
                            end: Icon(Icons.chevron_right),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      AdwTextField(
                          initialValue: "some text",
                          keyboardType: TextInputType.number,
                          labelText: "Text field label",
                          icon: Icons.insert_photo,
                          onChanged: (String s) {}),
                    ],
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
