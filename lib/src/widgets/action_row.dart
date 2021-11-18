import 'package:flutter/material.dart';

class AdwActionRowStyle {}

class AdwActionRow extends StatelessWidget {
  final Widget? start;
  final Widget? end;
  final String title;
  final String? subtitle;
  final VoidCallback? onActivated;
  final bool autofocus;
  final bool enabled;
  final EdgeInsets? contentPadding;
  final AdwActionRowStyle? style;

  const AdwActionRow({
    Key? key,
    this.start,
    this.end,
    required this.title,
    this.onActivated,
    this.subtitle,
    this.autofocus = false,
    this.enabled = true,
    this.style,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      autofocus: autofocus,
      enabled: enabled,
      contentPadding: contentPadding,
      leading: start,
      onTap: onActivated,
      title: Text(title),
      subtitle: subtitle != null && subtitle!.isNotEmpty ? Text(subtitle!) : null,
      trailing: end,
    );
  }
}
