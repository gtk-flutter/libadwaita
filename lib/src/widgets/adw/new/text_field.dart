import 'package:flutter/material.dart';

class AdwTextField extends StatelessWidget {
  const AdwTextField({
    super.key,
    this.controller,
    this.keyboardType,
    this.onChanged,
    this.icon,
    this.prefixIcon,
    this.onSubmitted,
    this.initialValue,
    this.autofocus = false,
  });

  /// Will automatically focus on this field when it's visible
  final bool autofocus;

  /// To be run when you submit this field using Enter key
  final ValueChanged<String>? onSubmitted;

  /// The controller for the field
  final TextEditingController? controller;

  /// Keyboard Type for this field
  final TextInputType? keyboardType;

  /// Runs when value is changed from this field
  final void Function(String)? onChanged;

  /// The suffix icon for this field
  final IconData? icon;

  /// The prefix icon for this field
  final IconData? prefixIcon;

  /// The initial value (if any) for this field
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      autofocus: autofocus,
      onFieldSubmitted: onSubmitted,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Theme.of(context).textTheme.displayLarge?.color,
              )
            : null,
        suffixIcon: icon != null
            ? Icon(
                icon,
                color: Theme.of(context).textTheme.displayLarge?.color,
              )
            : null,
      ),
      onChanged: onChanged,
    );
  }
}
