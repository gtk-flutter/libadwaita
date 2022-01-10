import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:window_decorations/window_decorations.dart';

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
    return Column(
      children: [
        AdwHeaderBar.bitsdojo(
          appWindow: appWindow,
          windowDecor: windowDecor,
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
        Expanded(
          child: AdwScaffold(
            flapController: _flapController,
            drawer: Drawer(
              child: AdwSidebar(
                currentIndex: _currentIndex,
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
                onSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                    Navigator.of(context).pop();
                  });
                },
              ),
            ),
            body: AdwFlap(
              locked: locked,
              flapController: _flapController,
              flapPosition: flapPosition,
              foldPolicy: foldPolicy,
              flap: AdwSidebar(
                currentIndex: _currentIndex,
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
                onSelected: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              child: AdwViewStack(
                index: _currentIndex,
                children: [
                  AdwClamp.scrollable(
                    child: AdwPreferencesGroup(
                      children: [
                        const AdwComboRow(
                          title: 'Fold Policy',
                          choices: ['auto', 'always', 'never'],
                        ),
                        AdwActionRow(
                          title: 'Locked',
                          subtitle: """
Sidebar visibility doesn't change when fold state changes""",
                          end: CupertinoSwitch(
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
                          end: ToggleButtons(
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
                        const AdwActionRow(
                          title: 'Transition type',
                          end: Text('Over'),
                        )
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
                          end:
                              CupertinoSwitch(value: true, onChanged: (val) {}),
                        ),
                        AdwActionRow(
                          title: 'Swipe to Open',
                          end:
                              CupertinoSwitch(value: true, onChanged: (val) {}),
                        ),
                        AdwActionRow(
                          title: 'Swipe to Close',
                          end:
                              CupertinoSwitch(value: true, onChanged: (val) {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
