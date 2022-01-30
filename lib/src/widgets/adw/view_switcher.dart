import 'package:flutter/material.dart';
import 'package:libadwaita/src/models/models.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

class AdwViewSwitcher extends StatelessWidget {
  const AdwViewSwitcher({
    Key? key,
    required this.tabs,
    required this.onViewChanged,
    required this.currentIndex,
    this.badgeColor,
    this.style,
    @Deprecated('This parameter is no longer in use')
        double height = 55,
    @Deprecated(
      'This field is now ignored. '
      'This feature was deprecated after v1.0.0-rc.2',
    )
        bool? expanded,
  })  : assert(tabs.length >= 2, 'Minimum 2 tabs are required'),
        super(key: key);

  final AdwColors? badgeColor;
  final List<ViewSwitcherData> tabs;
  final ValueChanged<int> onViewChanged;
  final ViewSwitcherStyle? style;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final newStyle = style ??
            (constraints.maxWidth > 600
                ? ViewSwitcherStyle.desktop
                : ViewSwitcherStyle.mobile);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final tab in tabs.asMap().entries)
              AdwViewSwitcherTab(
                data: tab.value,
                badgeColor: badgeColor,
                style: newStyle,
                isSelected: tab.key == currentIndex,
                onSelected: currentIndex != tab.key
                    ? () => onViewChanged(tab.key)
                    : null,
              )
          ],
        );
      },
    );
  }
}
