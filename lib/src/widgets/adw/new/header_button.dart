import 'package:flutter/material.dart';
import 'package:libadwaita/src/utils/colors.dart';

enum ButtonStatus { normal, hover, tapDown }

class AdwHeaderButton extends StatefulWidget {
  /// The icon of the button. Default size would be `17`.
  final Widget icon;

  /// Controls the active status, generally used for popup buttons.
  final bool isActive;

  /// Triggered when the button is pressed.
  final VoidCallback? onPressed;

  const AdwHeaderButton({
    Key? key,
    required this.icon,
    this.isActive = false,
    this.onPressed,
  }) : super(key: key);

  @override
  _AdwHeaderButtonState createState() => _AdwHeaderButtonState();
}

class _AdwHeaderButtonState extends State<AdwHeaderButton> {
  var status = ButtonStatus.normal;

  Color? _resolveColor() {
    if (Theme.of(context).brightness == Brightness.dark) {
      if (widget.isActive) {
        return Theme.of(context).appBarTheme.backgroundColor?.lighten(0.03);
      }

      switch (status) {
        case ButtonStatus.hover:
          return Theme.of(context).appBarTheme.backgroundColor?.lighten(0.03);
        case ButtonStatus.tapDown:
          return Theme.of(context).appBarTheme.backgroundColor?.lighten(0.20);
        default:
          return null;
      }
    } else {
      if (widget.isActive) {
        return Theme.of(context).appBarTheme.backgroundColor?.darken(0.05);
      }

      switch (status) {
        case ButtonStatus.hover:
          return Theme.of(context).appBarTheme.backgroundColor?.darken(0.05);
        case ButtonStatus.tapDown:
          return Theme.of(context).appBarTheme.backgroundColor?.darken(0.20);
        default:
          return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => status = ButtonStatus.hover),
      onExit: (_) => setState(() => status = ButtonStatus.normal),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => status = ButtonStatus.tapDown),
        onTapUp: (_) => setState(() => status = ButtonStatus.hover),
        child: AnimatedContainer(
          height: 34,
          width: 34,
          duration: const Duration(milliseconds: 200),
          curve: Curves.ease,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
            color: _resolveColor(),
          ),
          child: IconTheme.merge(
            data: Theme.of(context).iconTheme.copyWith(size: 17),
            child: widget.icon,
          ),
        ),
      ),
    );
  }
}
