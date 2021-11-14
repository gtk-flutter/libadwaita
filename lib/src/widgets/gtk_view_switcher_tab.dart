import 'package:gtk/gtk.dart';
import 'package:flutter/material.dart';

class GtkViewSwitcherTab extends StatelessWidget {
  final ViewSwitcherData data;
  final ViewSwitcherStyle style;
  final bool isSelected;

  const GtkViewSwitcherTab({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      data.icon,
      size: 18,
    );

    return style == ViewSwitcherStyle.desktop
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                if (data.icon != null) icon,
                if (data.icon != null && data.title != null)
                  const SizedBox(width: 8),
                if (data.title != null)
                  Text(
                    data.title!,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (data.icon != null) icon,
                if (data.icon != null && data.title != null)
                  const SizedBox(height: 2),
                if (data.title != null)
                  Text(
                    data.title!,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
              ],
            ),
          );
  }
}
