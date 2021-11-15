import 'package:flutter/material.dart';
import 'package:gtk/src/utils/colors.dart';

class GtkHeaderButton extends StatefulWidget {
  /// The icon of the button, use size of 17 for better results
  final Widget icon;

  /// Is this button active, generally it is for popup buttons
  final bool isActive;

  /// Triggered when the button is pressed.
  final VoidCallback? onPressed;

  const GtkHeaderButton({
    Key? key,
    required this.icon,
    this.isActive = false,
    this.onPressed,
  }) : super(key: key);

  @override
  _GtkHeaderButtonState createState() => _GtkHeaderButtonState();
}

class _GtkHeaderButtonState extends State<GtkHeaderButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (hover) {
        setState(() => hovering = hover);
      },
      child: AnimatedContainer(
          height: 34,
          width: 36,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            border: Border.all(
                width: 1,
                color: Theme.of(context).brightness == Brightness.light
                    ? borderLight
                    : borderDark),
            color: hovering
                ? Theme.of(context).appBarTheme.backgroundColor?.lighten(0.03)
                : Theme.of(context).appBarTheme.backgroundColor?.lighten(0.025),
          ),
          child: widget.icon),
    );
  }
}
