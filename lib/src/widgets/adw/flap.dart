import 'package:flutter/material.dart';
import 'package:libadwaita/src/animations/slide_hide.dart';
import 'package:libadwaita/src/controllers/flap_controller.dart';
import 'package:libadwaita/src/internal/window_resize_listener.dart';
import 'package:libadwaita/src/utils/colors.dart';

enum FoldPolicy { never, always, auto }

enum FlapPosition { start, end }

class FlapOptions {
  const FlapOptions({
    this.foldPolicy = FoldPolicy.auto,
    this.flapPosition = FlapPosition.start,
    this.visible = true,
  });

  /// The FoldPolicy of this flap, defaults to auto
  final FoldPolicy foldPolicy;

  /// The FlapPosition of this flap, defaults to start
  final FlapPosition flapPosition;

  /// The visiblity of this flap, defaults to true
  final bool visible;
}

class FlapStyle {
  const FlapStyle({
    this.separator,
    this.locked = false,
    this.breakpoint = 900,
    this.flapWidth = 270.0,
  });

  /// The separator b/w flap and the content
  final Widget? separator;

  /// The breakpoint for small devices
  final double breakpoint;

  /// flap has a width of `flapWidth`
  /// Rest is allocated to content
  final double flapWidth;

  /// Whether to keep the flap's open
  /// state when screen is resized or
  /// not
  final bool locked;
}

class AdwFlap extends StatefulWidget {
  const AdwFlap({
    super.key,
    required this.flap,
    required this.child,
    this.controller,
    FlapStyle? style,
    FlapOptions? options,
  })  : style = style ?? const FlapStyle(),
        options = options ?? const FlapOptions();

  /// The flap widget itself, Mainly is a `AdwSidebar` instance
  final Widget flap;

  /// The content of the page
  final Widget child;

  /// The style of this flap
  final FlapStyle style;

  /// The options for this flap
  final FlapOptions options;

  /// The controller for this flap
  final FlapController? controller;

  @override
  _AdwFlapState createState() => _AdwFlapState();
}

class _AdwFlapState extends State<AdwFlap> {
  late FlapController _controller;

  void rebuild() => setState(() {});

  @override
  void initState() {
    super.initState();

    if (widget.controller == null) {
      _controller = FlapController();
    } else {
      _controller = widget.controller!;
    }

    _controller.addListener(rebuild);
    updateFlapData();
    _controller.context = context;
  }

  void updateFlapData() {
    _controller
      ..policy = widget.options.foldPolicy
      ..position = widget.options.flapPosition
      ..locked = widget.style.locked;
  }

  @override
  void didUpdateWidget(covariant AdwFlap oldWidget) {
    updateFlapData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.removeListener(rebuild);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // probably shouldn;t do this but no one is looking :P
    _controller.context = context;

    final content = Expanded(
      child: widget.child,
    );

    final flap = SlideHide(
      isHidden: _controller.shouldHide(),
      width: widget.style.flapWidth,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: widget.flap,
      ),
    );

    final separator = widget.style.separator ??
        Container(
          width: 1,
          color: context.borderColor,
        );

    final children = [flap, separator, content];

    final finalChildren = widget.options.flapPosition == FlapPosition.start
        ? children
        : children.reversed.toList();

    if (!widget.options.visible) widget.controller?.close();

    return WindowResizeListener(
      onResize: (Size size) =>
          WidgetsBinding.instance.addPostFrameCallback((_) {
        // The stuff that happens when the window is resized
        // We check for the mobile state and update it on every resize
        // Do nothin if FoldPolicy is never / always, because they are not
        // affected by window resizes.
        // If FoldPolicy is auto, then close / open the sidebar depending on the
        // state
        final isMobile = size.width < widget.style.breakpoint;
        _controller.updateModalState(context, state: isMobile);
        if (!widget.options.visible) return;
        switch (widget.options.foldPolicy) {
          case FoldPolicy.never:
          case FoldPolicy.always:
            break;
          case FoldPolicy.auto:
            _controller.updateOpenState(state: !isMobile);
            break;
        }
      }),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: finalChildren,
      ),
    );
  }
}
