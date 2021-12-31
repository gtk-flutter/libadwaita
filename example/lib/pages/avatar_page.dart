import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      center: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AdwAvatar(
            child: Icon(Icons.person),
            size: 128,
          ),
          AdwPreferencesGroup(
            title: 'All colors',
            children: [
              for (var index
                  in List.generate(AdwAvatarColors.values.length, (i) => i))
                AdwActionRow(
                  start: AdwAvatar(
                    backgroundColor: AdwAvatarColors.values[index],
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
