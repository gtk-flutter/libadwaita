import 'package:gtk/gtk.dart';
import 'package:flutter/material.dart';

class GtkSidebar extends StatelessWidget {
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

  GtkSidebar({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 265,
    this.color,
    this.border,
    this.controller,
    this.padding,

    /// List of all the Gtk Sidebar Item's, use GtkSidebar.builder if you want to build them on demand.
    required List<GtkSidebarItem> children,
  })  : childrenDelegate = List.generate(
            children.length,
            (index) => _GtkSidebarItemBuilder(
                  item: (context) => children[index],
                  isSelected: index == currentIndex,
                  onSelected: () => onSelected(index),
                )),
        super(key: key);

  GtkSidebar.builder({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 265,
    this.color,
    this.border,
    // Create a vertical list of GtkSidebarItem on demand.
    required Function(BuildContext context, int index, bool isSelected)
        itemBuilder,
    required int itemCount,
    this.controller,
    this.padding,
  })  : assert(itemCount >= 0),
        childrenDelegate = List.generate(
          itemCount,
          (index) => _GtkSidebarItemBuilder(
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
          color: color ?? GnomeTheme.of(context).sidebars,
          border: border ??
              Border(
                right: BorderSide(
                  color: GnomeTheme.of(context).border,
                ),
              ),
        ),
        child: ListView(
          controller: controller,
          padding: padding,
          children: childrenDelegate,
        ));
  }
}

class GtkSidebarItem {
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

  GtkSidebarItem({
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

class _GtkSidebarItemBuilder extends StatelessWidget {
  final GtkSidebarItem Function(BuildContext context) item;
  final bool isSelected;
  final VoidCallback? onSelected;

  const _GtkSidebarItemBuilder({
    Key? key,
    required this.item,
    required this.isSelected,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentItem = item(context);
    var leading = IconTheme(
      data: IconThemeData(color: isSelected ? Colors.white : null),
      child: currentItem.leading ?? const SizedBox(),
    );

    return InkWell(
      onTap: onSelected,
      child: Container(
        color: isSelected
            ? currentItem.selectedColor ?? Theme.of(context).primaryColor
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
                    color: isSelected ? Colors.white : null,
                    fontSize: 15,
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
