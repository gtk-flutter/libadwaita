import 'package:libadwaita/libadwaita.dart';
import 'package:flutter/material.dart';

class AdwViewSwitcherTab extends StatelessWidget {
  final ViewSwitcherData data;
  final ViewSwitcherStyle style;
  final bool isSelected;
  final VoidCallback onSelected;

  const AdwViewSwitcherTab({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.onSelected,
    required this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      data.icon,
      size: 18,
    );

    bool isDesktop = style == ViewSwitcherStyle.desktop;

    return AdwButton.flat(
      constraints: isDesktop
          ? const BoxConstraints(minWidth: 120, maxHeight: 36)
          : const BoxConstraints(minWidth: 100, maxHeight: 36),
      margin:
          isDesktop ? const EdgeInsets.symmetric(vertical: 6) : EdgeInsets.zero,
      onPressed: onSelected,
      isActive: isSelected,
      child: _RowOrColumn(
        isRow: isDesktop,
        children: [
          if (data.icon != null) icon,
          if (data.icon != null && data.title != null)
            const SizedBox(width: 8, height: 2),
          if (data.title != null)
            Text(
              data.title!,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isDesktop ? 14 : 11,
                  ),
            ),
        ],
      ),
    );
  }
}

class _RowOrColumn extends StatelessWidget {
  final List<Widget> children;
  final bool isRow;

  const _RowOrColumn({
    Key? key,
    required this.isRow,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isRow
        ? Row(mainAxisAlignment: MainAxisAlignment.center, children: children)
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children);
  }
}
