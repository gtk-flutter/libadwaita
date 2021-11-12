import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';
import 'package:window_decorations/window_decorations.dart';

class MyHomePage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;

  const MyHomePage({Key? key, required this.themeNotifier}) : super(key: key);

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
            windowDecor: windowDecor,
            leading: GtkHeaderButton(
                icon: const Icon(Icons.add, size: 15),
                onPressed: _incrementCounter),
            center: MediaQuery.of(context).size.width >= 650
                ? buildViewSwitcher()
                : const SizedBox(),
            trailing: Row(
              children: [
                GtkPopupMenu(
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
          _currentIndex == 2
              ? Column(
                  children: [
                    GtkContainer(
                      child: SwitchListTile(
                          title: Text(
                            "Dark mode",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          value: widget.themeNotifier.value == ThemeMode.light
                              ? false
                              : true,
                          onChanged: (value) {
                            widget.themeNotifier.value =
                                widget.themeNotifier.value == ThemeMode.light
                                    ? ThemeMode.dark
                                    : ThemeMode.light;
                          }),
                    ),
                  ],
                )
              : _currentIndex == 1
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Center(
                          child: GtkContainer(
                            child: ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: 30,
                              itemBuilder: (context, index) => ListTile(
                                title: Text("Index $index"),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                color: Theme.of(context).border,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'You have pushed the add button this many times:'),
                          Text('$_counter',
                              style: Theme.of(context).textTheme.headline4),
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
      height: 55,
      tabs: const [
        ViewSwitcherData(icon: Icons.near_me_outlined, title: "Counter"),
        ViewSwitcherData(icon: Icons.list_outlined, title: "List View"),
        ViewSwitcherData(icon: Icons.settings, title: "Settings")
      ],
      style: viewSwitcherStyle,
      currentIndex: _currentIndex,
      onViewChanged: (index) => setState(() => _currentIndex = index),
    );
  }
}
