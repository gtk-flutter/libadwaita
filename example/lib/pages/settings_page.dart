import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      child: Column(
        children: [
          const AdwPreferencesGroup(
            title: 'Pages',
            description: '''
Preferences are organized in pages, this example has the following pages:''',
            children: [
              AdwActionRow(
                title: 'Layout',
              ),
              AdwActionRow(
                title: 'Search',
              ),
            ],
          ),
          const SizedBox(height: 12),
          const AdwPreferencesGroup(
            title: 'Groups',
            description: '''
Preferences are grouped together, a group can have a title and a description. 
Descriptions will be wrapped if they are too long. This page has the following groups:''',
            children: [
              AdwActionRow(title: 'An untitled group'),
              AdwActionRow(title: 'Pages'),
              AdwActionRow(title: 'Groups'),
              AdwActionRow(title: 'Preferences'),
            ],
          ),
          const SizedBox(height: 12),
          AdwPreferencesGroup(
            title: 'Subpages',
            description: 'Preferences windows can have subpages.',
            children: [
              AdwActionRow(
                title: 'Go to a subpage',
                end: const Icon(Icons.chevron_right),
                onActivated: () => debugPrint('Hi'),
              ),
              const AdwActionRow(
                title: 'Go to another subpage',
                end: Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AdwTextField(
            initialValue: 'some text',
            keyboardType: TextInputType.number,
            icon: Icons.insert_photo,
            onChanged: (String s) {},
          ),
        ],
      ),
    );
  }
}
