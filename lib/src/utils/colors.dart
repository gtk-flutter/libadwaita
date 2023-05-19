import 'package:flutter/material.dart';

const String _amountError = 'The amount should be b/w the range of 0 to 1';

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, _amountError);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1, _amountError);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

class AdwDefaultColors {
  static Color borderLight = Colors.black.withOpacity(0.18);
  static Color borderDark = const Color(0xFF454545);

  static Color blue = const Color(0xFF3584e4);
}

extension BorderContext on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  Color get borderColor =>
      _isDark ? AdwDefaultColors.borderDark : AdwDefaultColors.borderLight;
  Color get checkboxColor =>
      _isDark ? const Color(0xFF535353) : const Color(0xFFE0E0E0);

  Color get selectColor => _isDark
      ? Theme.of(this).colorScheme.background.lighten()
      : Theme.of(this).colorScheme.background.darken();

  Color get hoverMenuColor => _isDark
      ? Theme.of(this).colorScheme.background.lighten(0.05)
      : Theme.of(this).colorScheme.background.darken(0.05);

  Color get hoverColor => _isDark
      ? Theme.of(this).colorScheme.background.lighten(0.15)
      : Theme.of(this).colorScheme.background.darken(0.005);
  Color get textColor => _isDark ? Colors.white : Colors.black;
}
