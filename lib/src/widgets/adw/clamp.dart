import 'package:flutter/material.dart';

class AdwClamp extends StatefulWidget {
  const AdwClamp({
    super.key,
    required this.child,
    this.maximumSize = 580,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
    this.center = true,
  })  : isScrollable = false,
        controller = null;

  const AdwClamp.scrollable({
    super.key,
    required this.child,
    this.center = true,
    this.controller,
    this.maximumSize = 580,
    this.padding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(14),
  }) : isScrollable = true;

  /// Whether this clamp is scrollable or not
  final bool isScrollable;

  /// The controller for the scrollable clamp
  final ScrollController? controller;

  /// Whether to center the elements horizontally of the clamp
  final bool center;

  /// The child of this clamp
  final Widget child;

  /// Sets the maximum size allocated to the child.
  final double maximumSize;

  /// The padding around this clamp
  final EdgeInsets padding;

  /// The margin around this clamp
  final EdgeInsets margin;

  @override
  State<StatefulWidget> createState() => _AdwClampState();
}

class _AdwClampState extends State<AdwClamp> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final container = Container(
      constraints: BoxConstraints(maxWidth: widget.maximumSize),
      margin: widget.margin,
      padding: widget.padding,
      child: widget.child,
    );

    final centered = widget.center
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [Center(child: container)],
          )
        : container;

    return widget.isScrollable
        ? SingleChildScrollView(
            controller: widget.controller ?? _controller,
            child: centered,
          )
        : centered;
  }
}
