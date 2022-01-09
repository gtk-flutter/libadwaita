import 'package:flutter/material.dart';

class ViewSwitcherData {
  const ViewSwitcherData({
    this.icon,
    this.title,
  }) : assert(icon != null || title != null);

  final IconData? icon;
  final String? title;
}
