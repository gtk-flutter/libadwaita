import 'package:flutter/material.dart';
import 'package:libadwaita/src/utils/colors.dart';

class AdwClamp extends StatelessWidget {
  const AdwClamp({
    Key? key,
    required this.child,
    this.maximumSize = 580,
    this.borderWidth = 2,
    this.borderRadius = 18,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
  }) : super(key: key);

  final Widget child;
  final double maximumSize;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maximumSize),
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: context.borderColor,
          width: borderWidth,
        ),
      ),
      child: child,
    );
  }
}
