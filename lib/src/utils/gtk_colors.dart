import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

getGtkColor({
  required GtkColorType colorType,
  required bool isDark,
  GtkColorTheme colorTheme = GtkColorTheme.adwaita,
}) {
  switch (colorTheme) {
    case GtkColorTheme.adwaita:
      return _adwaita(isDark)[describeEnum(colorType)];
  }
}

getAdaptiveGtkColor(
  BuildContext context, {
  required GtkColorType colorType,
  GtkColorTheme colorTheme = GtkColorTheme.adwaita,
}) =>
    getGtkColor(
      colorType: colorType,
      isDark: Theme.of(context).brightness == Brightness.dark,
    );

enum GtkColorType {
  windowControlIconColor,
  canvas,
  headerBarBackgroundTop,
  headerBarBackgroundBottom,
  headerBarTopBorder,
  headerBarBottomBorder,
  headerButtonBackgroundTop,
  headerButtonBackgroundBottom,
  headerButtonBorder,
  headerButtonPrimary,
  headerSwitcherTabPrimary,
  headerSwitcherTabBackground,
  headerSwitcherTabBorder,
}

enum GtkColorTheme {
  adwaita,
}

Map<String, Color> _adwaita(bool isDark) {
  return {
    'windowControlIconColor':
        isDark ? const Color(0xFFEEEEEC) : const Color(0xFF2E3436),
    'canvas': isDark ? const Color(0xFF353535) : const Color(0xFFF6F5F4),
    'headerBarBackgroundTop':
        isDark ? const Color(0xFF2B2B2B) : const Color(0xFFE1DEDB),
    'headerBarBackgroundBottom':
        isDark ? const Color(0xFF262626) : const Color(0xFFDAD6D2),
    'headerBarTopBorder':
        isDark ? const Color(0xFF383838) : const Color(0xFFF9F8F8),
    'headerBarBottomBorder':
        isDark ? const Color(0xFF070707) : const Color(0xFFBFB8B1),
    'headerButtonBackgroundTop':
        isDark ? const Color(0xFF383838) : const Color(0xFFF6F5F3),
    'headerButtonBackgroundBottom':
        isDark ? const Color(0xFF333333) : const Color(0xFFEEECEA),
    'headerButtonBorder':
        isDark ? const Color(0xFF1B1B1B) : const Color(0xFFCEC8C3),
    'headerButtonPrimary':
        isDark ? const Color(0xFFEEEEEC) : const Color(0xFF393E40),
    'headerSwitcherTabPrimary':
        isDark ? const Color(0xFFE6E6E4) : const Color(0xFF2E3436),
    'headerSwitcherTabBackground':
        isDark ? const Color(0xFF1E1E1E) : const Color(0xFFD5D1CD),
    'headerSwitcherTabBorder':
        isDark ? const Color(0xFF1B1B1B) : const Color(0xFFCDC7C2),
  };
}
