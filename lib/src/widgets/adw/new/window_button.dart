import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libadwaita/src/utils/colors.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

enum WindowButtonType { close, maximize, minimize }

class AdwWindowButton extends StatelessWidget {
  const AdwWindowButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
    this.themeType,
    this.windowDecor,
  }) : super(key: key);

  /// The ThemeType from the window_decorations package, nullable
  final dynamic themeType;

  /// The windowDecor object from window_decorations package
  final Widget Function(
    String name,
    dynamic type,
    void Function()? windowDecor,
  )? windowDecor;

  /// Executed when this button is pressed
  final VoidCallback? onPressed;

  /// The WindowButtonType for this window
  final WindowButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return onPressed != null
        ? windowDecor != null
            ? windowDecor!(buttonType.name, themeType, onPressed)
            : AdwButton.circular(
                size: 24,
                margin: const EdgeInsets.all(6),
                onPressed: onPressed,
                child: Center(
                  child: SvgPicture.asset(
                    'packages/libadwaita/assets/icons/${buttonType.name}.svg',
                    width: 16,
                    height: 16,
                    color: context.textColor,
                  ),
                ),
              )
        : const SizedBox();
  }
}
