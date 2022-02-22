import 'package:flutter/material.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

@Deprecated('Use GtkToggleButton instead')
class AdwToggleButton {}

class GtkToggleButton extends StatelessWidget {
  const GtkToggleButton({
    Key? key,
    required this.children,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  final List<Widget> children;
  final void Function(int index) onPressed;
  final List<bool> isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        children.length,
        (index) => AdwButton.flat(
          onPressed: () => onPressed(index),
          isActive: isSelected[index],
          child: children[index],
        ),
      ),
    );
  }
}
