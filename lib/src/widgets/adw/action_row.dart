import 'package:flutter/material.dart';

class AdwActionRow extends StatelessWidget {
  const AdwActionRow({
    super.key,
    this.start,
    this.end,
    required this.title,
    this.onActivated,
    this.subtitle,
    this.horizontalTitleGap = 8,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding,
  });

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

  /// The horizontal gap between the titles and the leading/trailing widgets.
  final double horizontalTitleGap;

  /// The padding b/w content of this Action row
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      autofocus: autofocus,
      enabled: enabled,
      horizontalTitleGap: horizontalTitleGap,
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
