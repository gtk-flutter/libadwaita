import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

/// Button that is usually placed inside an `AdwHeaderBar` widget.
///
/// Via the `icon` parameter, a widget can be placed inside the button.
class AdwHeaderButton extends StatelessWidget {
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

  Color? _resolveBackgroundColor(BuildContext context, TargetStatus status) {
    if (Theme.of(context).brightness == Brightness.dark) {
      switch (status) {
        case TargetStatus.hover:
        case TargetStatus.active:
          return Theme.of(context).appBarTheme.backgroundColor?.lighten(0.03);
        case TargetStatus.tapDown:
          return Theme.of(context).appBarTheme.backgroundColor?.lighten(0.20);
        default:
          return null;
      }
    } else {
      switch (status) {
        case TargetStatus.hover:
        case TargetStatus.active:
          return Theme.of(context).appBarTheme.backgroundColor?.darken(0.05);
        case TargetStatus.tapDown:
          return Theme.of(context).appBarTheme.backgroundColor?.darken(0.20);
        default:
          return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawAdwTarget(
      constraints: BoxConstraints.tight(const Size.square(34)),
      backgroundColorBuilder: _resolveBackgroundColor,
      onPressed: onPressed,
      isActive: isActive,
      builder: (context, status) => IconTheme.merge(
        data: const IconThemeData(size: 17),
        child: icon,
      ),
    );
  }
}
