import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

///
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

  ///
  final List<Widget> _childrenDelegate;

  /// List of all the Adw Sidebar Item's, use AdwSidebar.builder if you want to build them on demand.
  AdwSidebar({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 260,
    this.color,
    this.border,
    this.controller,
    this.padding = const EdgeInsets.symmetric(vertical: 5),
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

  /// Create a vertical list of AdwSidebarItem on demand.
  AdwSidebar.builder({
    Key? key,
    required this.currentIndex,
    required this.onSelected,
    this.width = 260,
    this.color,
    this.border,
    this.controller,
    this.padding = const EdgeInsets.symmetric(vertical: 5),
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

///
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

  const AdwSidebarItem({
    this.key,
    this.label,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
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

  Color? _resolveBackgroundColor(
    BuildContext context,
    AdwButtonStatus status,
    AdwSidebarItem currentItem,
  ) {
    if (Theme.of(context).brightness == Brightness.dark) {
      switch (status) {
        case AdwButtonStatus.enabledHovered:
          return currentItem.selectedColor?.lighten(0.02) ??
              context.hoverMenuColor;

        case AdwButtonStatus.active:
          return currentItem.selectedColor ?? context.selectColor;

        case AdwButtonStatus.activeHovered:
          return (currentItem.selectedColor ?? context.selectColor)
              .lighten(0.10);

        case AdwButtonStatus.tapDown:
          return (currentItem.selectedColor ?? context.selectColor)
              .lighten(0.20);
        default:
          return currentItem.unselectedColor;
      }
    } else {
      switch (status) {
        case AdwButtonStatus.enabledHovered:
          return currentItem.selectedColor?.darken(0.02) ??
              context.hoverMenuColor;

        case AdwButtonStatus.active:
          return currentItem.selectedColor ?? context.selectColor;

        case AdwButtonStatus.activeHovered:
          return (currentItem.selectedColor ?? context.selectColor)
              .darken(0.10);

        case AdwButtonStatus.tapDown:
          return (currentItem.selectedColor ?? context.selectColor)
              .darken(0.20);
        default:
          return currentItem.unselectedColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = item(context);

    return AdwButton(
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      padding: currentItem.padding,
      onPressed: onSelected,
      backgroundColorBuilder: (context, state) =>
          _resolveBackgroundColor(context, state, currentItem),
      isActive: isSelected,
      builder: (context, state) => Row(
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
