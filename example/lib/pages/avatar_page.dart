import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AdwAvatar(
            size: 128,
            child: Icon(Icons.person),
          ),
          AdwPreferencesGroup(
            title: 'All colors',
            children: [
              for (var index
                  in List.generate(AdwColors.values.length, (i) => i))
                AdwActionRow(
                  start: AdwAvatar(
                    backgroundColor: AdwColors.values[index],
                    child: Text(index.toString()),
                  ),
                  title: 'Johnny Appleseed',
                ),
            ],
          ),
        ],
      ),
    );
  }
}
