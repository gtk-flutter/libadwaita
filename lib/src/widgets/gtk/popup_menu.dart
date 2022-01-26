import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:popover/popover.dart';

class AdwPopupMenu extends StatefulWidget {
  const AdwPopupMenu({
    Key? key,
    required this.body,
    this.icon = const Icon(Icons.menu, size: 17),
    this.popupWidth = 200,
    this.popupHeight,
  }) : super(key: key);

  /// The body of the popup
  final Widget body;

  // The icon for Popup menu, use size of 17 for better results
  final Widget icon;

  /// The width of the popup
  final double popupWidth;

  /// The height of the popup
  final double? popupHeight;

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
          shadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.40),
              blurRadius: 6,
            ),
          ],
          barrierColor: Colors.transparent,
          bodyBuilder: (_) => Padding(
            padding: const EdgeInsets.all(4),
            child: widget.body,
          ),
          width: widget.popupWidth,
          height: widget.popupHeight,
          backgroundColor: Theme.of(context).cardColor,
          // contentOffset: const Offset(0, 4),
        ).whenComplete(() => setState(() => isActive = false));
      },
    );
  }
}
