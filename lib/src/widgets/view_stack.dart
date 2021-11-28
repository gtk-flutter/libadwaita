import 'package:flutter/material.dart';

class AdwViewStack extends StatefulWidget {
  const AdwViewStack({
    Key? key,
    this.index,
    required this.children,
    this.animationCurve = Curves.ease,
    this.animationDuration = const Duration(milliseconds: 450),
  }) : super(key: key);

  final int? index;
  final List<Widget> children;
  final Curve animationCurve;
  final Duration animationDuration;

  @override
  _AdwViewStackState createState() => _AdwViewStackState();
}

class _AdwViewStackState extends State<AdwViewStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _yAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _yAnimation = Tween(begin: -10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _scaleAnimation = Tween(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AdwViewStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      setState(() {
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform(
          transform: Matrix4(1, 0, 0, 0, 0, _scaleAnimation.value, 0, 0, 0, 0,
              1, 0, 0, 0, 0, 1),
          child: Transform.translate(
            offset: Offset(0, _yAnimation.value),
            child: IndexedStack(
              index: widget.index,
              children: widget.children,
            ),
          ),
        );
      },
    );
  }
}
