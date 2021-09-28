import 'package:gtk/gtk.dart';
import 'package:popover/popover.dart';
import 'package:flutter/material.dart';
import './gtk_header_button.dart';
import '../utils/utils.dart';

class GtkPopupMenu extends StatefulWidget {
  /// The Theme by which the color scheme
  /// of the Popup menu will be based of
  final GnomeTheme gnomeTheme;

  /// The body of the popup
  final Widget body;

  // The icon for Popup menu, use size of 17 for better results
  final Widget icon;

  /// The width of the popup
  final double popupWidth;

  /// The height of the popup
  final double? popupHeight;

  const GtkPopupMenu({
    Key? key,
    required this.gnomeTheme,
    required this.body,
    this.icon = const Icon(Icons.menu, size: 17),
    this.popupWidth = 200,
    this.popupHeight,
  }) : super(key: key);

  @override
  State<GtkPopupMenu> createState() => _GtkPopupMenuState();
}

class _GtkPopupMenuState extends State<GtkPopupMenu> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return GtkHeaderButton(
      gnomeTheme: widget.gnomeTheme,
      icon: Center(child: widget.icon),
      isActive: isActive,
      onPressed: () {
        setState(() => isActive = true);
        showPopover(
          context: context,
          barrierColor: Colors.transparent,
          contentDyOffset: 4,
          shadow: [
            BoxShadow(
              color: getAdaptiveGtkColor(context,
                  gnomeTheme: widget.gnomeTheme,
                  colorType: GtkColorType.headerButtonBorder),
              blurRadius: 8,
            )
          ],
          backgroundColor: getAdaptiveGtkColor(context,
              gnomeTheme: widget.gnomeTheme, colorType: GtkColorType.canvas),
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
