import 'package:flutter/material.dart';

class ViewSwitcherData {
  final IconData? icon;
  final String? title;

  const ViewSwitcherData({
    this.icon,
    this.title,
  }) : assert(icon != null || title != null);
}
