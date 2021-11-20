import 'package:flutter/material.dart';

class AnimatedIndexedStack extends StatefulWidget {
  const AnimatedIndexedStack({Key? key, this.index, required this.children})
      : super(key: key);

  final int? index;
  final List<Widget> children;

  @override
  _AnimatedIndexedStackState createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _yAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _yAnimation = Tween(begin: -10.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.ease),
    );

    _scaleAnimation = Tween(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.ease),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedIndexedStack oldWidget) {
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
