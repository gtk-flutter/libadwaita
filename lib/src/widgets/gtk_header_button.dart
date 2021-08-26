import 'package:flutter/material.dart';
import '../utils/utils.dart';

class GtkHeaderButton extends StatefulWidget {
  /// The icon of the button, use size of 17 for better results
  final Widget icon;

  /// Is this button active, generally it is for popup buttons
  final bool isActive;

  /// Triggered when the button is pressed.
  final VoidCallback? onPressed;

  final GtkColorTheme colorTheme;

  const GtkHeaderButton({
    Key? key,
    required this.icon,
    this.isActive = false,
    this.colorTheme = GtkColorTheme.adwaita,
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
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        child: Container(
          height: 34,
          width: 36,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: getAdaptiveGtkColor(
                  context,
                  colorType: GtkColorType.headerButtonBorder,
                  colorTheme: widget.colorTheme,
                ),
              ),
              color: getAdaptiveGtkColor(
                context,
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
                colorTheme: widget.colorTheme,
              )),
          child: widget.icon,
        ),
      ),
    );
  }

  void _updateColor([bool value = true]) => setState(() => hovering = value);
}
