import 'package:example/pages/run_demo_screen.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final switchVal = ValueNotifier(false);
    const choices = ['Test', 'Second', 'Third and a long name'];
    final selectionIndex = ValueNotifier<int>(0);

    return DemoScreen(
      image: const Icon(
        Icons.list_rounded,
        size: 150,
      ),
      title: 'Lists',
      description: 'Rows and helpers for GtkListBox.',
      footer: Column(
        children: [
          AdwPreferencesGroup(
            children: [
              const AdwActionRow(
                start: Icon(Icons.settings),
                title: 'Rows have a title',
                subtitle: 'They also have a subtitle and an icon',
              ),
              AdwActionRow(
                title: 'Rows can have suffix widgets',
                end: AdwButton(
                  onPressed: () {},
                  child: const Text('Frobnicate'),
                ),
              )
            ],
          ),
          AdwPreferencesGroup(
            children: [
              ValueListenableBuilder<int>(
                valueListenable: selectionIndex,
                builder: (context, val, _) {
                  return AdwComboRow(
                    choices: choices,
                    title: 'Combo row',
                    selectedIndex: val,
                    onSelected: (val) => selectionIndex.value = val,
                  );
                },
              )
            ],
          ),
          AdwPreferencesGroup(
            children: List.generate(
              3,
              (index) => AdwActionRow(
                title: 'Index $index',
              ),
            ),
          ),
          AdwPreferencesGroup(
            children: [
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: const Text('Expander row'),
                  children: [
                    const ListTile(
                      title: Text('A nested row'),
                    ),
                    Divider(
                      color: context.borderColor,
                      height: 10,
                    ),
                    const ListTile(
                      title: Text('Another nested row'),
                    )
                  ],
                ),
              )
            ],
          ),
          AdwPreferencesGroup(
            children: [
              ValueListenableBuilder<bool>(
                valueListenable: switchVal,
                builder: (context, val, _) => AdwSwitchRow(
                  title: 'Switch example',
                  value: val,
                  onChanged: (v) {
                    switchVal.value = v;
                  },
                ),
              ),
            ],
          ),
        ]
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: e,
              ),
            )
            .toList(),
      ),
    );
  }
}
