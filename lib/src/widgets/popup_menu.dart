import 'package:libadwaita/libadwaita.dart';
import 'package:popover/popover.dart';
import 'package:flutter/material.dart';

class AdwPopupMenu extends StatefulWidget {
  /// The body of the popup
  final Widget body;

  // The icon for Popup menu, use size of 17 for better results
  final Widget icon;

  /// The width of the popup
  final double popupWidth;

  /// The height of the popup
  final double? popupHeight;

  const AdwPopupMenu({
    Key? key,
    required this.body,
    this.icon = const Icon(Icons.menu, size: 17),
    this.popupWidth = 200,
    this.popupHeight,
  }) : super(key: key);

  @override
  State<AdwPopupMenu> createState() => _AdwPopupMenuState();
}

class _AdwPopupMenuState extends State<AdwPopupMenu> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return AdwHeaderButton(
      icon: Center(child: widget.icon),
      isActive: isActive,
      onPressed: () {
        setState(() => isActive = true);
        showPopover(
          context: context,
          barrierColor: Colors.transparent,
          contentDyOffset: 4,
          backgroundColor: Theme.of(context).cardColor,
          transitionDuration: const Duration(milliseconds: 150),
          bodyBuilder: (context) => SizedBox(child: widget.body),
          direction: PopoverDirection.top,
          width: widget.popupWidth,
          height: widget.popupHeight,
          arrowHeight: 10,
          arrowWidth: 22,
        ).whenComplete(() => setState(() => isActive = false));
      },
    );
  }
}
