import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';

class GtkHeaderButton extends StatefulWidget {
  final Widget icon;

  /// Triggered when the button is pressed.
  final VoidCallback? onPressed;

  final GtkColorTheme systemTheme;

  const GtkHeaderButton({
    Key? key,
    required this.icon,
    this.systemTheme = GtkColorTheme.adwaita,
    this.onPressed,
  }) : super(key: key);

  @override
  _GtkHeaderButtonState createState() => _GtkHeaderButtonState(
      icon: icon, systemTheme: systemTheme, onPressed: onPressed);
}

class _GtkHeaderButtonState extends State<GtkHeaderButton> {
  bool hovering = false;

  /// The icon of the button
  final Widget icon;

  /// Triggered when the button is pressed.
  final VoidCallback? onPressed;

  final GtkColorTheme systemTheme;

  _GtkHeaderButtonState({
    required this.icon,
    this.systemTheme = GtkColorTheme.adwaita,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onExit: _removeColor,
        onHover: _updateColor,
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
                colorTheme: systemTheme,
              ),
            ),
            gradient: hovering
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      getAdaptiveGtkColor(
                        context,
                        colorType:
                            GtkColorType.headerButtonBackgroundBottomHover,
                        colorTheme: systemTheme,
                      ),
                      getAdaptiveGtkColor(
                        context,
                        colorType: GtkColorType.headerButtonBackgroundTopHover,
                        colorTheme: systemTheme,
                      ),
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      getAdaptiveGtkColor(
                        context,
                        colorType: GtkColorType.headerButtonBackgroundBottom,
                        colorTheme: systemTheme,
                      ),
                      getAdaptiveGtkColor(
                        context,
                        colorType: GtkColorType.headerButtonBackgroundTop,
                        colorTheme: systemTheme,
                      ),
                    ],
                  ),
          ),
          child: IconButton(
            icon: icon,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: onPressed,
          ),
        ));
  }

  void _updateColor(PointerHoverEvent ev) {
    setState(() {
      hovering = true;
    });
  }

  void _removeColor(PointerExitEvent ev) {
    setState(() {
      hovering = false;
    });
  }
}
