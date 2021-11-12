import 'package:gtk/gtk.dart';
import 'package:flutter/material.dart';

class GtkViewSwitcher extends StatelessWidget {
  final List<ViewSwitcherData> tabs;
  final ValueChanged<int> onViewChanged;
  final ViewSwitcherStyle style;
  final int currentIndex;
  final bool expanded;
  final double height;

  const GtkViewSwitcher({
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final tab in tabs.asMap().entries)
          () {
            var ctab = InkWell(
              onTap:
                  currentIndex != tab.key ? () => onViewChanged(tab.key) : null,
              child: Container(
                height: height,
                decoration: BoxDecoration(
                  color: tab.key == currentIndex
                      ? Theme.of(context).viewSwitcher
                      : Colors.transparent,
                  border: Border.symmetric(
                    vertical: BorderSide(
                      width: 1,
                      color: tab.key == currentIndex
                          ? Theme.of(context).border
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: GtkViewSwitcherTab(
                  data: tab.value,
                  isSelected: tab.key == currentIndex,
                  style: style,
                ),
              ),
            );
            return expanded ? Expanded(child: ctab) : ctab;
          }()
      ],
    );
  }
}
