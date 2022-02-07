import 'package:flutter/material.dart';
import 'package:libadwaita/src/models/models.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

class AdwViewSwitcherTab extends StatelessWidget {
  const AdwViewSwitcherTab({
    Key? key,
    required this.data,
    required this.style,
    this.badgeColor,
    this.isSelected = false,
    this.onSelected,
  }) : super(key: key);

  final Color? badgeColor;
  final ViewSwitcherData data;
  final ViewSwitcherStyle style;
  final bool isSelected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final isDesktop = style == ViewSwitcherStyle.desktop;

    return AdwButton.flat(
      constraints: isDesktop
          ? const BoxConstraints(minWidth: 120, maxHeight: 38)
          : const BoxConstraints(minWidth: 75),
      margin:
          isDesktop ? const EdgeInsets.fromLTRB(0, 6, 3, 6) : EdgeInsets.zero,
      onPressed: onSelected,
      isActive: isSelected,
      textStyle: TextStyle(fontSize: isDesktop ? null : 11),
      borderRadius: isDesktop ? BorderRadius.circular(6) : BorderRadius.zero,
      child: _AdwViewSwitcherTabLayout(
        isRow: isDesktop,
        children: [
          if (data.icon != null)
            Stack(
              children: [
                Padding(
                  padding: isDesktop
                      ? const EdgeInsets.only(top: 4, bottom: 4, right: 8)
                      : const EdgeInsets.only(top: 3.5, right: 4, left: 4),
                  child: Icon(data.icon, size: 17),
                ),
                if (data.badge != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: SizedBox(
                      height: 14,
                      width: 14,
                      child: CircleAvatar(
                        backgroundColor:
                            badgeColor ?? AdwColors.blue.backgroundColor,
                        child: Text(
                          data.badge!,
                          style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          if (data.icon != null && data.title != null)
            const SizedBox(height: 1.5),
          if (data.title != null)
            Padding(
              padding: isDesktop
                  ? const EdgeInsets.symmetric(vertical: 4)
                  : EdgeInsets.zero,
              child: Text(data.title!),
            ),
        ],
      ),
    );
  }
}

class _AdwViewSwitcherTabLayout extends StatelessWidget {
  const _AdwViewSwitcherTabLayout({
    Key? key,
    required this.isRow,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;
  final bool isRow;

  @override
  Widget build(BuildContext context) {
    return isRow
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          );
  }
}
