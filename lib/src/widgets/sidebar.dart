import 'package:flutter/material.dart';
import 'package:libadwaita/src/utils/colors.dart';

class AdwSidebar extends StatelessWidget {
  /// The current index of the item selected
  final int? currentIndex;

  /// The padding of the Sidebar
  final EdgeInsets? padding;

  /// Scroll controller for sidebar
  final ScrollController? controller;

  /// Called when one of the Sidebar item is selected
  final Function(int index) onSelected;

  /// The width of the sidebar
  final double width;

  /// The background color of the sidebar
  final Color? color;

  /// The border around the sidebar
  final Border? border;

  final List<Widget> childrenDelegate;

  AdwSidebar({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 265,
    this.color,
    this.border,
    this.controller,
    this.padding,

    /// List of all the Adw Sidebar Item's, use AdwSidebar.builder if you want to build them on demand.
    required List<AdwSidebarItem> children,
  })  : childrenDelegate = List.generate(
            children.length,
            (index) => _AdwSidebarItemBuilder(
                  item: (context) => children[index],
                  isSelected: index == currentIndex,
                  onSelected: () => onSelected(index),
                )),
        super(key: key);

  AdwSidebar.builder({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 265,
    this.color,
    this.border,
    // Create a vertical list of AdwSidebarItem on demand.
    required Function(BuildContext context, int index, bool isSelected)
        itemBuilder,
    required int itemCount,
    this.controller,
    this.padding,
  })  : assert(itemCount >= 0),
        childrenDelegate = List.generate(
          itemCount,
          (index) => _AdwSidebarItemBuilder(
            item: (context) =>
                itemBuilder(context, index, currentIndex == index),
            isSelected: currentIndex == index,
            onSelected: () => onSelected(index),
          ),
        ),
        super(key: key);

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
          children: childrenDelegate,
        ));
  }
}

class AdwSidebarItem {
  /// The key of the gtk sidebar item child.
  final Key? key;

  /// The label to render to the right of the button
  final String? label;

  /// The background color of the item when it is selected, defaults to Theme's primary color
  final Color? selectedColor;

  /// The background color of the item when it is not selected, defaults to null
  final Color? unselectedColor;

  /// The style of the label
  final TextStyle? labelStyle;

  /// The label to render to the right of the button
  final Widget? labelWidget;

  // the leading widget for sidebar item, use size of 19 for better results
  final Widget? leading;

  // The Padding of the item
  final EdgeInsets padding;

  AdwSidebarItem({
    this.key,
    this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
    this.selectedColor,
    this.unselectedColor,
    this.labelStyle,
    this.labelWidget,
    this.leading,
  }) : assert(labelWidget != null || label != null);
}

class _AdwSidebarItemBuilder extends StatelessWidget {
  final AdwSidebarItem Function(BuildContext context) item;
  final bool isSelected;
  final VoidCallback? onSelected;

  const _AdwSidebarItemBuilder({
    Key? key,
    required this.item,
    required this.isSelected,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentItem = item(context);
    var leading = currentItem.leading ?? const SizedBox();

    return InkWell(
      onTap: onSelected,
      child: Container(
        color: isSelected
            ? currentItem.selectedColor ??
                Theme.of(context).appBarTheme.backgroundColor?.lighten(0.05)
            : currentItem.unselectedColor,
        padding: currentItem.padding,
        child: Row(
          children: [
            leading,
            const SizedBox(width: 12),
            currentItem.labelWidget ??
                Text(
                  currentItem.label!,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : null,
                    fontSize: 15,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
