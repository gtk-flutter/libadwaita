import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class ListsPage extends StatelessWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final switchVal = ValueNotifier(false);
    const choices = ['Test', 'Second', 'Third and a long name'];
    final selectionIndex = ValueNotifier<int>(0);

    return AdwClamp.scrollable(
      child: Column(
        children: [
          const Icon(
            Icons.list_rounded,
            size: 150,
          ),
          Text(
            'Lists',
            style: Theme.of(context)
                .textTheme
                .headline5
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Text('Rows and helpers for GtkListBox.'),
          const SizedBox(
            height: 10,
          ),
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
              (index) => ListTile(
                title: Text('Index $index'),
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
          ValueListenableBuilder<bool>(
            valueListenable: switchVal,
            builder: (context, val, _) => AdwSwitch(
              value: val,
              onChanged: (v) {
                switchVal.value = v;
              },
            ),
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
