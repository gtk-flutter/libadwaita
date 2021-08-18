import 'package:flutter/material.dart';
import '../utils/utils.dart';

class GtkHeaderButton extends StatelessWidget {
  /// The icon of the button
  final Widget icon;

  /// The background color for the button
  final Color? color;

  /// Triggered when the button is pressed.
  final VoidCallback? onPressed;

  const GtkHeaderButton({
    Key? key,
    this.color,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 36,
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: getAdaptiveGtkColor(
            context,
            colorType: GtkColorType.headerButtonBorder,
          ),
        ),
        color: color,
        gradient: color == null
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  getAdaptiveGtkColor(
                    context,
                    colorType: GtkColorType.headerBarBackgroundBottom,
                  ),
                  getAdaptiveGtkColor(
                    context,
                    colorType: GtkColorType.headerBarBackgroundTop,
                  ),
                ],
              )
            : null,
      ),
      child: IconButton(
        icon: icon,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: onPressed,
      ),
    );
  }
}
