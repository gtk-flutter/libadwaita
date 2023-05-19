import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AdwViewSwitcherTab extends StatelessWidget {
  const AdwViewSwitcherTab({
    super.key,
    required this.data,
    required this.policy,
    this.badgeColor,
    this.isSelected = false,
    this.onSelected,
    this.paddingIcon,
  });

  /// The color of the badge at the top right of the tab's icon
  final Color? badgeColor;

  /// The of this view switcher  tab
  final ViewSwitcherData data;

  /// The Policy of the parent view switcher, either narrow or widget
  final ViewSwitcherPolicy policy;

  /// Whether this tab is selected or not, defaults to false
  final bool isSelected;

  /// Executed when this tab is selected
  final VoidCallback? onSelected;

  /// The Padding for the icon of the view switcher tab
  final EdgeInsets? paddingIcon;

  @override
  Widget build(BuildContext context) {
    final isDesktop = policy == ViewSwitcherPolicy.wide;

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
                  padding: paddingIcon ??
                      (isDesktop
                          ? const EdgeInsets.only(top: 4, bottom: 4, right: 8)
                          : const EdgeInsets.only(
                              right: 4,
                              left: 4,
                            )),
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
                        backgroundColor: badgeColor ?? AdwDefaultColors.blue,
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
          if (data.title != null) Text(data.title!),
        ],
      ),
    );
  }
}

class _AdwViewSwitcherTabLayout extends StatelessWidget {
  const _AdwViewSwitcherTabLayout({
    required this.isRow,
    required this.children,
  });

  /// The list of all the child widget
  final List<Widget> children;

  /// Whether this tab layout is row or column
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
