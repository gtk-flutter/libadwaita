import 'package:flutter/material.dart';

class AdwClamp extends StatelessWidget {
  const AdwClamp({
    Key? key,
    required this.child,
    this.maximumSize = 580,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
    this.center = true,
  }) : super(key: key);

  AdwClamp.scrollable({
    Key? key,
    required Widget child,
    this.center = true,

    /// Scroll Controller for SingleChildScrollView
    ScrollController? controller,
    this.maximumSize = 580,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
  })  : child = SingleChildScrollView(child: child),
        super(key: key);

  final bool center;
  final Widget child;
  final double maximumSize;
  final EdgeInsets padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    var container = Container(
      constraints: BoxConstraints(maxWidth: maximumSize),
      margin: margin,
      padding: padding,
      child: child,
    );

    return center
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Flexible(child: container)],
          )
        : container;
  }
}
