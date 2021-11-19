import 'package:flutter/material.dart';
import 'package:libadwaita/src/animations/animated_indexed_stack.dart';
import 'package:libadwaita/src/animations/slide_hide.dart';
import 'package:libadwaita/src/utils/colors.dart';

enum FoldPolicy { never, always, auto }
enum FlapPosition { start, end }

class AdwFlap extends StatefulWidget {
  final Widget flap;
  final List<Widget> children;
  final Widget? seperator;

  final FoldPolicy foldPolicy;
  final FlapPosition flapPosition;

  /// Keeps track of the content index
  final int? index;

  /// The breakpoint for small devices
  final double breakpoint;

  /// flap has a width of `flapWidth`
  /// Rest is allocated to content
  final double flapWidth;

  const AdwFlap({
    Key? key,
    required this.flap,
    required this.children,
    this.seperator,
    this.foldPolicy = FoldPolicy.auto,
    this.flapPosition = FlapPosition.start,
    this.breakpoint = 800,
    this.flapWidth = 256,
    this.index,
  }) : super(key: key);

  @override
  _AdwFlapState createState() => _AdwFlapState();
}

class _AdwFlapState extends State<AdwFlap> {
  @override
  Widget build(BuildContext context) {
    bool shouldHide;

    switch (widget.foldPolicy) {
      case FoldPolicy.never:
        shouldHide = false;
        break;
      case FoldPolicy.always:
        shouldHide = true;
        break;
      case FoldPolicy.auto:
        shouldHide = MediaQuery.of(context).size.width < widget.breakpoint;
        break;
    }

    var content = Expanded(
      child: AnimatedIndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );

    var flap = SlideHide(
      isHidden: shouldHide,
      width: widget.flapWidth,
      child: widget.flap,
    );

    var seperator = widget.seperator ??
        Container(
          width: 1,
          color: context.borderColor,
        );

    var widgets = widget.flapPosition == FlapPosition.start
        ? [flap, seperator, content]
        : [content, seperator, flap];

    return Row(
      children: widgets,
    );
  }
}
