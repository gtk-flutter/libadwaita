import 'package:flutter/material.dart';

class AdwActionRow extends StatelessWidget {
  const AdwActionRow({
    Key? key,
    this.start,
    this.end,
    required this.title,
    this.onActivated,
    this.subtitle,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding,
  }) : super(key: key);

  /// The starting elemets of this row
  final Widget? start;

  /// The ending elements of this row
  final Widget? end;

  /// The title of this row
  final String title;

  /// The subtitle of this row
  final String? subtitle;

  /// Executed when this Action row is pressed
  final VoidCallback? onActivated;

  /// Whether to focus automatically when this widget is visible
  /// defaults to false
  final bool autofocus;

  /// Whether this action row is enabled or not, defaults to true
  final bool enabled;

  /// The padding b/w content of this Action row
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      autofocus: autofocus,
      enabled: enabled,
      contentPadding: contentPadding,
      leading: start != null
          ? SizedBox(height: double.infinity, child: start)
          : null,
      onTap: onActivated,
      title: Text(title),
      subtitle:
          subtitle != null && subtitle!.isNotEmpty ? Text(subtitle!) : null,
      trailing: end,
    );
  }
}
