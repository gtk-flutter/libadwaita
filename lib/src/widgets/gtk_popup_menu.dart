import 'package:popover/popover.dart';
import 'package:flutter/material.dart';
import 'package:adwaita_icons/adwaita_icons.dart';
import './gtk_header_button.dart';
import '../utils/utils.dart';

class GtkPopupMenu extends StatelessWidget {
  /// The body of the popup
  final Widget body;

  // The icon for Popup menu
  final String? icon;

  /// The width of the popup
  final double popupWidth;

  /// The height of the popup
  final double? popupHeight;

  const GtkPopupMenu({
    Key? key,
    required this.body,
    this.icon,
    this.popupWidth = 200,
    this.popupHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GtkHeaderButton(
      icon: Center(
        child: AdwaitaIcon(
          icon ?? AdwaitaIcons.menu,
          size: 17,
        ),
      ),
      onPressed: () {
        showPopover(
          context: context,
          barrierColor: Colors.transparent,
          contentDyOffset: 4,
          shadow: [
            BoxShadow(
              color: getAdaptiveGtkColor(context,
                  colorType: GtkColorType.headerSwitcherTabBorder),
              blurRadius: 8,
            )
          ],
          backgroundColor: getAdaptiveGtkColor(
            context,
            colorType: GtkColorType.headerButtonBackgroundTop,
          ),
          transitionDuration: const Duration(milliseconds: 150),
          bodyBuilder: (context) => SizedBox(child: body),
          direction: PopoverDirection.top,
          width: popupWidth,
          height: popupHeight,
          arrowHeight: 10,
          arrowWidth: 22,
        );
      },
    );
  }
}
