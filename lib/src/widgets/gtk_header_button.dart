import 'package:flutter/material.dart';
import '../utils/utils.dart';

class GtkHeaderButton extends StatefulWidget {
  /// The Theme by which the color scheme
  /// of the Header button will be based of
  final GnomeTheme gnomeTheme;

  /// The icon of the button, use size of 17 for better results
  final Widget icon;

  /// Is this button active, generally it is for popup buttons
  final bool isActive;

  /// Triggered when the button is pressed.
  final VoidCallback? onPressed;

  /// The margin of the [GtkHeaderButton]
  final EdgeInsets margin;

  /// The padding of the [GtkHeaderButton]
  final EdgeInsets padding;

  const GtkHeaderButton({
    Key? key,
    required this.gnomeTheme,
    required this.icon,
    this.padding = const EdgeInsets.all(8),
    this.isActive = false,
    this.margin = const EdgeInsets.symmetric(horizontal: 5),
    this.onPressed,
  }) : super(key: key);

  @override
  _GtkHeaderButtonState createState() => _GtkHeaderButtonState();
}

class _GtkHeaderButtonState extends State<GtkHeaderButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (_) => _updateColor(false),
      onHover: (_) => _updateColor(),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          height: 34,
          padding: widget.padding,
          width: 36,
          margin: widget.margin,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: getAdaptiveGtkColor(
                  context,
                  gnomeTheme: widget.gnomeTheme,
                  colorType: GtkColorType.headerButtonBorder,
                ),
              ),
              color: getAdaptiveGtkColor(
                context,
                gnomeTheme: widget.gnomeTheme,
                colorType: widget.isActive
                    ? Theme.of(context).brightness == Brightness.dark
                        ? GtkColorType.headerButtonBackgroundTop
                        : GtkColorType.headerButtonBackgroundBottom
                    : Theme.of(context).brightness == Brightness.dark
                        ? hovering
                            ? GtkColorType.headerButtonBackgroundBottomHover
                            : GtkColorType.headerButtonBackgroundBottom
                        : hovering
                            ? GtkColorType.headerButtonBackgroundTopHover
                            : GtkColorType.headerButtonBackgroundTop,
              )),
          child: widget.icon,
        ),
      ),
    );
  }

  void _updateColor([bool value = true]) => setState(() => hovering = value);
}
