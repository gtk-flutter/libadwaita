import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libadwaita/src/utils/colors.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

enum AdwWindowButtonType { close, maximize, minimize }

class AdwWindowButton extends StatelessWidget {
  const AdwWindowButton({
    Key? key,
    required this.buttonType,
    required this.onPressed,
    this.themeType,
    this.windowDecor,
  }) : super(key: key);

  final dynamic themeType;

  final Widget Function(
    String name,
    dynamic type,
    void Function()? windowDecor,
  )? windowDecor;
  final VoidCallback? onPressed;
  final AdwWindowButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return onPressed != null
        ? windowDecor != null
            ? windowDecor!(buttonType.name, themeType, onPressed)
            : AdwButton.circular(
                size: 25,
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
