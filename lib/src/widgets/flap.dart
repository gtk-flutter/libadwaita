import 'package:flutter/material.dart';
import 'package:libadwaita/src/animations/animated_indexed_stack.dart';
import 'package:libadwaita/src/animations/slide_hide.dart';
import 'package:libadwaita/src/controllers/flap_controller.dart';
import 'package:libadwaita/src/utils/colors.dart';

enum FoldPolicy { never, always, auto }
enum FlapPosition { start, end }

class AdwFlap extends StatefulWidget {
  final Widget flap;
  final List<Widget> children;
  final Widget? seperator;

  final FoldPolicy foldPolicy;
  final FlapPosition flapPosition;

  final FlapController? flapController;

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
    this.flapController,
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

class _AdwFlapState extends State<AdwFlap> with WidgetsBindingObserver {
  late Size _lastSize;
  bool wasWindowResized = true;

  late FlapController _controller;

  void rebuild() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _lastSize = WidgetsBinding.instance!.window.physicalSize;
    WidgetsBinding.instance!.addObserver(this);

    if (widget.flapController == null) {
      _controller = FlapController();
    } else {
      _controller = widget.flapController!;
    }

    _controller.addListener(rebuild);
    updateFlapData();
  }

  void updateFlapData() {
    _controller.policy = widget.foldPolicy;
  }

  @override
  void didUpdateWidget(covariant AdwFlap oldWidget) {
    updateFlapData();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    _controller.removeListener(rebuild);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      var winSize = WidgetsBinding.instance!.window.physicalSize;

      if (winSize != _lastSize) {
        wasWindowResized = true;
        _lastSize = winSize;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // The stuff that happens when the window is resized
      // We check for the mobile state and update it on every resize
      // Do nothin if FoldPolicy is never / always, because they are not
      // affected by window resizes.
      // If FoldPolicy is auto, then close / open the sidebar depending on the
      // state
      if (wasWindowResized) {
        var isMobile = MediaQuery.of(context).size.width < widget.breakpoint;
        _controller.updateModalState(context, isMobile);

        switch (widget.foldPolicy) {
          case FoldPolicy.never:
          case FoldPolicy.always:
            break;
          case FoldPolicy.auto:
            _controller.updateOpenState(!isMobile);
            break;
        }
        wasWindowResized = false;
      }
    });

    var content = Expanded(
      child: AnimatedIndexedStack(
        index: widget.index,
        children: widget.children,
      ),
    );

    var flap = SlideHide(
      isHidden: _controller.shouldHide(),
      width: widget.flapWidth,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: widget.flap,
        scrollDirection: Axis.horizontal,
      ),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
