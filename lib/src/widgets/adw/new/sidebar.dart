import 'package:flutter/material.dart';
import 'package:libadwaita/src/widgets/adw/button.dart';

const String _bothLabelAndLabelWidget = """
Either use label or use labelWidget, both can't be assigned at once.""";

/// View that is normally used to place navigation and selection items
/// at the side of the app.
///
/// You can use the [AdwSidebar.builder] constructor to build the sidebar's
/// children on demand.
class AdwSidebar extends StatelessWidget {
  AdwSidebar({
    super.key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 270.0,
    this.color,
    this.isDrawer = false,
    this.controller,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    required List<AdwSidebarItem> children,
  }) : _childrenDelegate = List.generate(
          children.length,
          (index) => _AdwSidebarItemBuilder(
            item: (context) => children[index],
            isDrawer: isDrawer,
            isSelected: index == currentIndex,
            onSelected: () => onSelected(index),
          ),
        );

  AdwSidebar.builder({
    super.key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 270.0,
    this.color,
    this.isDrawer = false,
    this.controller,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    required AdwSidebarItem Function(
      BuildContext context,
      int index,
      bool isSelected,
    ) itemBuilder,
    required int itemCount,
  })  : assert(itemCount >= 0, 'Item Count cannot not be negative!'),
        _childrenDelegate = List.generate(
          itemCount,
          (index) => _AdwSidebarItemBuilder(
            item: (context) =>
                itemBuilder(context, index, currentIndex == index),
            isSelected: currentIndex == index,
            isDrawer: isDrawer,
            onSelected: () => onSelected(index),
          ),
        );

  /// The current index of the item selected.
  final int? currentIndex;

  /// The padding of the sidebar.
  ///
  /// Defaults to `EdgeInsets.symmetric(vertical: 5, horizontal: 6)`.
  final EdgeInsets? padding;

  /// Scroll controller for sidebar.
  final ScrollController? controller;

  /// Called when one of the Sidebar item is selected.
  final void Function(int index) onSelected;

  /// Is the Sidebar present in the Drawer of the Scaffold
  final bool isDrawer;

  /// The width of the sidebar.
  ///
  /// Defaults to `270.0`.
  final double width;

  /// The background color of the sidebar.
  final Color? color;

  /// Delegate in charge of supplying children to the internal list
  /// of this widget.
  final List<Widget> _childrenDelegate;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.background,
      ),
      child: ListView(
        controller: controller,
        padding: padding,
        children: _childrenDelegate,
      ),
    );
  }
}

/// Class that contains details about a specific sidebar item.
class AdwSidebarItem {
  const AdwSidebarItem({
    this.key,
    this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 14),
    this.selectedColor,
    this.unselectedColor,
    this.labelStyle,
    this.labelWidget,
    this.leading,
  }) : assert(
          labelWidget != null || label != null,
          _bothLabelAndLabelWidget,
        );

  /// The key of the sidebar item child.
  final Key? key;

  /// The label to render to the right of the button.
  final String? label;

  /// The background color of the item when it is selected.
  ///
  /// Defaults to Theme's primary color
  final Color? selectedColor;

  /// The background color of the item when it is not selected.
  ///
  /// Defaults to `null`.
  final Color? unselectedColor;

  /// The style of the label
  final TextStyle? labelStyle;

  /// The label to render to the right of the button
  final Widget? labelWidget;

  /// Widget that would be placed at the left of the [labelWidget].
  final Widget? leading;

  /// The Padding of the item.
  final EdgeInsets padding;
}

class _AdwSidebarItemBuilder extends StatelessWidget {
  const _AdwSidebarItemBuilder({
    required this.item,
    required this.isSelected,
    required this.isDrawer,
    this.onSelected,
  });

  final AdwSidebarItem Function(BuildContext context) item;
  final bool isSelected;
  final VoidCallback? onSelected;
  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    final currentItem = item(context);

    return AdwButton.flat(
      constraints: const BoxConstraints.tightFor(height: 36),
      margin: const EdgeInsets.only(bottom: 2),
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: currentItem.padding,
      onPressed: () {
        onSelected?.call();
        if (isDrawer) {
          Navigator.of(context).pop();
        }
      },
      isActive: isSelected,
      child: Row(
        children: [
          if (currentItem.leading != null) ...[
            currentItem.leading!,
            const SizedBox(width: 12),
          ],
          currentItem.labelWidget ??
              Text(
                currentItem.label!,
                style: currentItem.labelStyle ??
                    const TextStyle(
                      fontSize: 15,
                    ),
              ),
        ],
      ),
    );
  }
}
