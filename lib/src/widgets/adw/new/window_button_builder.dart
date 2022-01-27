import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:libadwaita/libadwaita.dart';

enum WindowButtonType { close, maximize, minimize }

class AdwWindowButtonBuilder extends StatelessWidget {
  const AdwWindowButtonBuilder({
    Key? key,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final WindowButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return onPressed != null
        ? AdwButton.circular(
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
            // CustomPaint(
            //   size: const Size(16, 16),
            //   painter: () {
            //     switch (buttonType) {
            //       case WindowButtonType.close:
            //         return CloseWBPainter(color: context.textColor);
            //       case WindowButtonType.maximize:
            //         return MaximizeWBPainter(color: context.textColor);
            //       case WindowButtonType.minimize:
            //         return MinimizeWBPainter(color: context.textColor);
            //     }
            //   }(),),
          )
        : const SizedBox();
  }
}
