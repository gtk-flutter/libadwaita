import 'package:flutter/material.dart';

class AdwTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final Function(String)? onChanged;
  final IconData? icon;
  final String? initialValue;

  const AdwTextField(
      {Key? key,
      this.controller,
      this.keyboardType,
      this.labelText,
      this.onChanged,
      this.icon,
      this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        isDense: true,
        suffixIcon: icon != null
            ? Icon(
                icon,
                color: Theme.of(context).textTheme.headline1?.color,
              )
            : null,
        labelText: labelText,
      ),
      onChanged: onChanged,
    );
  }
}
