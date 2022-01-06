import 'package:libadwaita/libadwaita.dart';
import 'package:flutter/material.dart';

class AdwViewSwitcher extends StatelessWidget {
  final List<ViewSwitcherData> tabs;
  final ValueChanged<int> onViewChanged;
  final ViewSwitcherStyle? style;
  final int currentIndex;
  final double height;

  const AdwViewSwitcher({
    Key? key,
    required this.tabs,
    required this.onViewChanged,
    required this.currentIndex,
    this.style,
    this.height = 55,
    @Deprecated(
      'This field is now ignored. '
      'This feature was deprecated after v1.0.0-rc.2',
    )
        bool? expanded,
  })  : assert(tabs.length >= 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewSwitcherStyle newStyle = style ??
        (MediaQuery.of(context).size.width > 600
            ? ViewSwitcherStyle.desktop
            : ViewSwitcherStyle.mobile);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final tab in tabs.asMap().entries)
          AdwViewSwitcherTab(
            data: tab.value,
            isSelected: tab.key == currentIndex,
            onSelected:
                currentIndex != tab.key ? () => onViewChanged(tab.key) : () {},
            style: newStyle,
          )
      ],
    );
  }
}
