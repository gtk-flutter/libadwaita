import 'package:flutter/material.dart';
import 'package:libadwaita/src/models/models.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

class AdwViewSwitcher extends StatelessWidget {
  const AdwViewSwitcher({
    super.key,
    required this.tabs,
    required this.onViewChanged,
    required this.currentIndex,
    this.badgeColor,
    this.policy,
    @Deprecated('This parameter is no longer in use')
        double height = 55,
    @Deprecated(
      'This field is now ignored. '
      'This feature was deprecated after v1.0.0-rc.2',
    )
        bool? expanded,
    this.paddingIcon,
  }) : assert(tabs.length >= 2, 'Minimum 2 tabs are required');

  /// The color of the badge at the top right of the tab's icon
  final Color? badgeColor;

  /// The tabs of this view switcher
  final List<ViewSwitcherData> tabs;

  /// Executed when the view switcher tab is changed
  final ValueChanged<int> onViewChanged;

  /// The Policy of this view switcher defaults to wide for desktop and
  /// narrow for mobile
  final ViewSwitcherPolicy? policy;

  /// The current index of the selected view
  final int currentIndex;

  /// The Padding for the icon of the view switcher tab
  final EdgeInsets? paddingIcon;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final newPolicy = policy ??
            (constraints.maxWidth > 600
                ? ViewSwitcherPolicy.wide
                : ViewSwitcherPolicy.narrow);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final tab in tabs.asMap().entries)
              AdwViewSwitcherTab(
                data: tab.value,
                paddingIcon: paddingIcon,
                badgeColor: badgeColor,
                policy: newPolicy,
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
