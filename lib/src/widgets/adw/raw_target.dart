import 'package:flutter/material.dart';

enum TargetStatus { enabled, active, hover, tapDown }

typedef ColorBuilder = Color? Function(BuildContext, TargetStatus);

typedef TargetWidgetBuilder = Widget Function(BuildContext, TargetStatus);

class RawAdwTarget extends StatefulWidget {
  const RawAdwTarget({
    Key? key,
    this.padding = EdgeInsets.zero,
    required this.builder,
    this.onPressed,
    required this.backgroundColorBuilder,
    this.constraints,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8.0),
    ),
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.ease,
    this.isActive = false,
  }) : super(key: key);

  final EdgeInsets padding;

  final TargetWidgetBuilder builder;

  final VoidCallback? onPressed;

  final ColorBuilder backgroundColorBuilder;

  final BoxConstraints? constraints;

  final BorderRadius borderRadius;

  final Duration animationDuration;

  final Curve animationCurve;

  final bool isActive;

  @override
  State<StatefulWidget> createState() => _RawAdwTargetState();
}

class _RawAdwTargetState extends State<RawAdwTarget> {
  late TargetStatus _status;

  @override
  void initState() {
    super.initState();
    _status = widget.isActive ? TargetStatus.active : TargetStatus.enabled;
  }

  @override
  void didUpdateWidget(covariant RawAdwTarget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _status = widget.isActive ? TargetStatus.active : TargetStatus.enabled;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _status = TargetStatus.hover),
      onExit: (_) => setState(
        () => _status =
            widget.isActive ? TargetStatus.active : TargetStatus.enabled,
      ),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => _status = TargetStatus.tapDown),
        onTapUp: (_) => setState(
          () => _status =
              widget.isActive ? TargetStatus.active : TargetStatus.enabled,
        ),
        child: AnimatedContainer(
          padding: widget.padding,
          constraints: widget.constraints,
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            color: widget.backgroundColorBuilder(context, _status),
          ),
          child: widget.builder(context, _status),
        ),
      ),
    );
  }
}
