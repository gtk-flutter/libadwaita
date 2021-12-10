import 'package:libadwaita/libadwaita.dart';
import 'package:flutter/material.dart';

class AdwViewSwitcher extends StatelessWidget {
  final List<ViewSwitcherData> tabs;
  final ValueChanged<int> onViewChanged;
  final ViewSwitcherStyle style;
  final int currentIndex;
  final bool expanded;
  final double height;

  const AdwViewSwitcher({
    Key? key,
    required this.tabs,
    required this.onViewChanged,
    required this.currentIndex,
    this.style = ViewSwitcherStyle.desktop,
    this.height = 55,
    bool? expanded,
  })  : expanded =
            expanded ?? (style == ViewSwitcherStyle.desktop ? false : true),
        assert(tabs.length >= 2),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: tabs.asMap().entries.map((tab) {
          return AdwViewSwitcherTab(
            data: tab.value,
            isSelected: tab.key == currentIndex,
            style: style,
            onTap:
                currentIndex != tab.key ? () => onViewChanged(tab.key) : null,
          );
        }).toList(),
      ),
    );
  }
}
