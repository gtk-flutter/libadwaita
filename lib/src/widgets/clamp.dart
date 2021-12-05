import 'package:flutter/material.dart';

class AdwClamp extends StatelessWidget {
  final bool isScrollable;
  final ScrollController? controller;

  const AdwClamp({
    Key? key,
    required this.child,
    this.maximumSize = 580,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
    this.center = true,
  })  : isScrollable = false,
        controller = null,
        super(key: key);

  const AdwClamp.scrollable({
    Key? key,
    required this.child,
    this.center = true,
    this.controller,
    this.maximumSize = 580,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
  })  : isScrollable = true,
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

    var centered = center
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Center(child: container)],
          )
        : container;

    return isScrollable
        ? SingleChildScrollView(
            controller: controller,
            child: centered,
          )
        : centered;
  }
}
