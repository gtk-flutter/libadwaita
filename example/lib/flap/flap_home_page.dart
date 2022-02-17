import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';

class FlapHomePage extends StatefulWidget {
  const FlapHomePage({Key? key, required this.themeNotifier}) : super(key: key);

  final ValueNotifier<ThemeMode> themeNotifier;

  @override
  State<FlapHomePage> createState() => _FlapHomePageState();
}

class _FlapHomePageState extends State<FlapHomePage> {
  int? _currentIndex = 0;

  late ScrollController _scrollController;
  late ScrollController _scrollControllerOther;
  late FlapController _flapController;
  FlapPosition flapPosition = FlapPosition.start;
  FoldPolicy foldPolicy = FoldPolicy.auto;
  bool locked = false;
  int selectionIndex = 0;

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

  void changeTheme() =>
      widget.themeNotifier.value = widget.themeNotifier.value == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return AdwScaffold(
      flapController: _flapController,
      headerbar: (_) => AdwHeaderBar(
        actions: AdwActions().bitsdojo,
        start: [
          Builder(
            builder: (context) {
              return AdwHeaderButton(
                icon: const Icon(Icons.view_sidebar, size: 15),
                isActive: _flapController.isOpen,
                onPressed: () => _flapController.toggle(),
              );
            },
          ),
          AdwHeaderButton(
            icon: const Icon(Icons.nightlight_round, size: 15),
            onPressed: changeTheme,
          ),
        ],
        title: const Text('AdwFlap Demo'),
      ),
      flap: (isDrawer) => AdwSidebar(
        currentIndex: _currentIndex,
        isDrawer: isDrawer,
        children: const [
          AdwSidebarItem(
            label: 'Folding',
          ),
          AdwSidebarItem(
            label: 'Layout',
          ),
          AdwSidebarItem(
            label: 'Interaction',
          )
        ],
        onSelected: (index) => setState(() => _currentIndex = index),
      ),
      flapStyle: FlapStyle(
        locked: locked,
        flapPosition: flapPosition,
        foldPolicy: FoldPolicy.values[selectionIndex],
      ),
      body: AdwViewStack(
        index: _currentIndex,
        children: [
          AdwClamp.scrollable(
            child: AdwPreferencesGroup(
              children: [
                AdwComboRow(
                  title: 'Fold Policy',
                  selectedIndex: selectionIndex,
                  onSelected: (val) => setState(() => selectionIndex = val),
                  choices: FoldPolicy.values.map((e) => e.name).toList(),
                ),
                AdwActionRow(
                  title: 'Locked',
                  subtitle: """
Sidebar visibility doesn't change when fold state changes""",
                  end: AdwSwitch(
                    value: locked,
                    onChanged: (val) {
                      locked = val;
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          ),
          AdwClamp.scrollable(
            child: AdwPreferencesGroup(
              children: [
                AdwActionRow(
                  title: 'Flap position',
                  end: AdwToggleButton(
                    isSelected: [
                      flapPosition.index == 0,
                      flapPosition.index == 1
                    ],
                    onPressed: (val) => setState(() {
                      if (val == 0) {
                        flapPosition = FlapPosition.start;
                      } else {
                        flapPosition = FlapPosition.end;
                      }
                    }),
                    children: const [
                      Text('Start'),
                      Text('End'),
                    ],
                  ),
                ),
                AdwComboRow(
                  title: 'Transition type',
                  selectedIndex: 0,
                  onSelected: (val) {},
                  choices: const ['Over', 'Under', 'Slide'],
                ),
              ],
            ),
          ),
          AdwClamp.scrollable(
            child: AdwPreferencesGroup(
              children: [
                AdwActionRow(
                  title: 'Modal',
                  subtitle: '''
Clicking outside the sidebar or pressing Esc will close it when folded''',
                  end: AdwSwitch(value: true, onChanged: (val) {}),
                ),
                AdwActionRow(
                  title: 'Swipe to Open',
                  end: AdwSwitch(value: true, onChanged: (val) {}),
                ),
                AdwActionRow(
                  title: 'Swipe to Close',
                  end: AdwSwitch(value: true, onChanged: (val) {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
