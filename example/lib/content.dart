import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';
import 'package:window_decorations/window_decorations.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.gnomeTheme,
  }) : super(key: key);

  final String title;
  final GnomeTheme gnomeTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          GtkHeaderBar.bitsdojo(
            appWindow: appWindow,
            gnomeTheme: widget.gnomeTheme,
            windowDecor: windowDecor,
            leading: GtkHeaderButton(
                gnomeTheme: widget.gnomeTheme,
                icon: const Icon(Icons.add, size: 15),
                onPressed: _incrementCounter),
            center: MediaQuery.of(context).size.width >= 650
                ? buildViewSwitcher()
                : const SizedBox(),
            trailing: Row(
              children: [
                GtkPopupMenu(
                  gnomeTheme: widget.gnomeTheme,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('You have pushed the add button this many times:'),
                Text('$_counter', style: Theme.of(context).textTheme.headline4),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 650
          ? buildViewSwitcher(ViewSwitcherStyle.mobile)
          : null,
    );
  }

  GtkViewSwitcher buildViewSwitcher(
      [ViewSwitcherStyle viewSwitcherStyle = ViewSwitcherStyle.desktop]) {
    return GtkViewSwitcher(
      gnomeTheme: widget.gnomeTheme,
      height: 55,
      tabs: const [
        ViewSwitcherData(icon: Icons.star_outline, title: "Explore"),
        ViewSwitcherData(icon: Icons.list_outlined, title: "Installed"),
        ViewSwitcherData(icon: Icons.find_replace_rounded, title: "Updates")
      ],
      style: viewSwitcherStyle,
      currentIndex: _currentIndex,
      onViewChanged: (index) => setState(() => _currentIndex = index),
    );
  }
}
