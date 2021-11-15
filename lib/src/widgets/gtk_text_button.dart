import 'package:flutter/material.dart';

class GtkTextButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;
  final Widget child;

  const GtkTextButton({
    Key? key,
    required this.onPressed,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    required this.child,
  }) : super(
          key: key,
        );

  @override
  _GtkTextButtonState createState() => _GtkTextButtonState();
}

class _GtkTextButtonState extends State<GtkTextButton> {
  _GtkTextButtonState();

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: widget.onPressed,
        onLongPress: widget.onLongPress,
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              side: BorderSide(color: Colors.transparent)),
        ),
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        clipBehavior: widget.clipBehavior,
        child: widget.child);
  }
}
