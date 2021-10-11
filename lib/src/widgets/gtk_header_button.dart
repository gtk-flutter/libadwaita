import 'package:flutter/material.dart';

class GtkHeaderButton extends StatefulWidget {
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
          child: widget.icon,
        ),
      ),
    );
  }

  void _updateColor([bool value = true]) => setState(() => hovering = value);
}
