import 'package:flutter/material.dart';

class AdwViewStack extends StatefulWidget {
  const AdwViewStack({
    super.key,
    this.index,
    required this.children,
    this.animationDuration = const Duration(milliseconds: 450),
  });

  /// The selected index of the element in this view stack
  final int? index;

  /// All the elements in this view stack
  final List<Widget> children;

  /// The duration of the animation while switching the elements
  /// in this view stack
  final Duration animationDuration;

  @override
  _AdwViewStackState createState() => _AdwViewStackState();
}

class _AdwViewStackState extends State<AdwViewStack>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: widget.animationDuration,
      child: widget.children[widget.index ?? 0],
    );
  }
}
