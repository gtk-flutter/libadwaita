import 'package:flutter/material.dart';

class AdwActionRow extends StatelessWidget {
  final Widget? start;
  final Widget? end;
  final String title;
  final String? subtitle;

  const AdwActionRow({
    Key? key,
    this.start,
    this.end,
    required this.title,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: start,
      title: Text(title),
      subtitle: subtitle != null && subtitle!.isNotEmpty ? Text(subtitle!) : null,
      trailing: end,
    );
  }
}
