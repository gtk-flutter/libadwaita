import 'package:flutter/material.dart';

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

var borderLight = Colors.black.withOpacity(0.18);
var borderDark = const Color(0xFF454545);

extension BorderContext on BuildContext {
  Color get borderColor =>
      Theme.of(this).brightness == Brightness.dark ? borderDark : borderLight;
}

extension SelectContext on BuildContext {
  Color get selectColor => Theme.of(this).brightness == Brightness.dark
      ? Theme.of(this).backgroundColor.lighten(0.1)
      : Theme.of(this).backgroundColor.darken(0.1);

  Color get hoverColor => Theme.of(this).brightness == Brightness.dark
      ? Theme.of(this).backgroundColor.lighten(0.05)
      : Theme.of(this).backgroundColor.darken(0.05);
}
