import 'package:flutter/material.dart';

class AdwClamp extends StatefulWidget {
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

  final bool isScrollable;
  final ScrollController? controller;
  final bool center;
  final Widget child;
  final double maximumSize;
  final EdgeInsets padding;
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
