import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

/// View that is normally used to place navigation and selection items
/// at the side of the app.
///
/// You can use the [AdwSidebar.builder] constructor to build the sidebar's
/// children on demand.
class AdwSidebar extends StatelessWidget {
  AdwSidebar({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 270.0,
    this.color,
    this.border,
    this.controller,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    required List<AdwSidebarItem> children,
  })  : _childrenDelegate = List.generate(
          children.length,
          (index) => _AdwSidebarItemBuilder(
            item: (context) => children[index],
            isSelected: index == currentIndex,
            onSelected: () => onSelected(index),
          ),
        ),
        super(key: key);

  AdwSidebar.builder({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 270.0,
    this.color,
    this.border,
    this.controller,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
    required AdwSidebarItem Function(
      BuildContext context,
      int index,
      bool isSelected,
    )
        itemBuilder,
    required int itemCount,
  })  : assert(itemCount >= 0),
        _childrenDelegate = List.generate(
          itemCount,
          (index) => _AdwSidebarItemBuilder(
            item: (context) =>
                itemBuilder(context, index, currentIndex == index),
            isSelected: currentIndex == index,
            onSelected: () => onSelected(index),
          ),
        ),
        super(key: key);

  /// The current index of the item selected.
  final int? currentIndex;

  /// The padding of the sidebar.
  ///
  /// Defaults to `EdgeInsets.symmetric(vertical: 5, horizontal: 6)`.
  final EdgeInsets? padding;

  /// Scroll controller for sidebar.
  final ScrollController? controller;

  /// Called when one of the Sidebar item is selected.
  final Function(int index) onSelected;

  /// The width of the sidebar.
  ///
  /// Defaults to `270.0`.
  final double width;

  /// The background color of the sidebar.
  final Color? color;

  /// The border around the sidebar.
  final Border? border;

  /// Delegate in charge of supplying children to the internal list
  /// of this widget.
  final List<Widget> _childrenDelegate;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: width),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).backgroundColor,
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
  }) : assert(labelWidget != null || label != null);

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
    Key? key,
    required this.item,
    required this.isSelected,
    this.onSelected,
  }) : super(key: key);

  final AdwSidebarItem Function(BuildContext context) item;
  final bool isSelected;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final currentItem = item(context);

    return AdwButton.flat(
      constraints: const BoxConstraints.tightFor(height: 36),
      margin: const EdgeInsets.only(bottom: 2),
      textStyle: const TextStyle(fontWeight: FontWeight.normal),
      padding: currentItem.padding,
      onPressed: onSelected,
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
