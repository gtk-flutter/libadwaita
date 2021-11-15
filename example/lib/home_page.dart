import 'package:bitsdojo_window/bitsdojo_window.dart';
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
  int _counter = 0;
  int? _currentIndex = 0;

  void _incrementCounter() => setState(() => _counter++);

  void changeTheme() =>
      widget.themeNotifier.value = widget.themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AdwHeaderBar.bitsdojo(
            appWindow: appWindow,
            windowDecor: windowDecor,
            start: AdwHeaderButton(icon: const Icon(Icons.nightlight_round, size: 15), onPressed: changeTheme),
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
                        title: const Text('Reset Counter', style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: AdwStackSidebar(
            fullContentBuilder: (contentIdx, content) => Column(
              children: [
                AdwHeaderBar.bitsdojo(
                  appWindow: appWindow,
                  windowDecor: windowDecor,
                  start: AdwHeaderButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      _currentIndex = null;
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(child: Center(child: content)),
              ],
            ),
            sidebar: AdwSidebar(
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
            content: Center(child: SingleChildScrollView(child: buildPanel())),
            onContentPopupClosed: () {},
          )),
        ],
      ),
    );
  }

  Widget buildPanel() {
    return _currentIndex == 2
        ? Column(
            children: [
              AdwClamp(
                child: Column(
                  children: [
                    const AdwPreferencesGroup(
                      title: "Pages",
                      description: "Preferences are organized in pages, this example has the following pages:",
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
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: GtkTextField(
                      initialValue: "some text",
                      keyboardType: TextInputType.number,
                      labelText: "text field label",
                      icon: Icons.insert_photo,
                      onChanged: (String s) {})),
              GtkTextButton(child: const Text("Hello"), onPressed: () {}),
            ],
          )
        : _currentIndex == 1
            ? AdwClamp(
                child: AdwPreferencesGroup(
                  children: List.generate(
                    15,
                    (index) => ListTile(
                      title: Text("Index $index"),
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You have pushed the add button this many times:'),
                  Text('$_counter', style: Theme.of(context).textTheme.headline4),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
                    onPressed: _incrementCounter,
                    child: const Text("Add"),
                  ),
                ],
              );
  }
}
