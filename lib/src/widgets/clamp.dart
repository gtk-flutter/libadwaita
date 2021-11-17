import 'package:flutter/material.dart';

class AdwClamp extends StatelessWidget {
  const AdwClamp({
    Key? key,
    required this.child,
    this.maximumSize = 580,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
  }) : super(key: key);

  final Widget child;
  final double maximumSize;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maximumSize),
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
