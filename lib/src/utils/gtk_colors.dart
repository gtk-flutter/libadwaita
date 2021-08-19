import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dart:io';
import 'dart:ui';
import 'package:from_css_color/from_css_color.dart';
import 'package:gsettings/gsettings.dart';

class GnomeTheme {
  String contents = "";

  Color? themeBgColor;
  Color? textColor;
  Color? buttonFg;
  Color? themeBaseColor;
  Color? insensitiveBgColor;
  // Border of widgets not text inputs fields
  Color? unfocusedBorder;
  Color? border;
  Color? themeSelectedBG;
  Color? textSelectedFG;

  GnomeTheme() {
    loadFromFile();
    parse();
  }

  void loadFromFile() {
    final settings = GSettings(schemaId: 'org.gnome.desktop.interface');
    final theme = settings.stringValue('gtk-theme');
    String fileName = "/usr/share/themes/" + theme + "/gtk-3.0/gtk.css";
    File file = File(fileName);
    if (file.existsSync()) {
      contents = File(fileName).readAsStringSync();
    }
  }

  ThemeData data(context) {
    ThemeData themedata = ThemeData(
        iconTheme: IconThemeData(color: textColor),
        brightness: Brightness.dark,
        canvasColor: themeBgColor,
        textSelectionTheme: TextSelectionThemeData(cursorColor: textColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                primary: buttonFg, onPrimary: textColor)),
        textTheme: TextTheme(
            bodyText2: TextStyle(color: textColor),
            bodyText1: TextStyle(color: textColor)),
        primaryColor: themeBaseColor);
    return themedata.copyWith(
        colorScheme: themedata.colorScheme.copyWith(secondary: textColor));
  }

  /// Get standard gtk color define
  Color? getBaseColor(String colorName) {
    String demand = "(@define-color " + colorName + " )(.*);";
    RegExp exp = RegExp(demand);

    RegExpMatch? matches = exp.firstMatch(contents);
    String? color = matches?.group(2).toString();
    if (color != null) {
      return fromCssColor(color);
    }
    return null;
  }

  void parse() {
    themeBgColor = getBaseColor("theme_base_color");
    textColor = getBaseColor("theme_text_color");
    buttonFg = getBaseColor("button_fg_color");
    themeBaseColor = getBaseColor("theme_base_color");
    insensitiveBgColor = getBaseColor("insensitive_bg_color");
    unfocusedBorder = getBaseColor("unfocused_borders");
    border = getBaseColor("borders");
    themeSelectedBG = getBaseColor("theme_selected_bg_color");
    textSelectedFG = getBaseColor("theme_selected_fg_color");

    buttonFg ??= themeBgColor;
  }
}

getGtkColor({
  required GtkColorType colorType,
  required bool isDark,
  GtkColorTheme colorTheme = GtkColorTheme.adwaita,
}) {
  switch (colorTheme) {
    case GtkColorTheme.adwaita:
      return _adwaita(isDark)[describeEnum(colorType)];
    case GtkColorTheme.system:
      var theme = GnomeTheme();
      theme.loadFromFile();
      theme.parse();
      return _system(theme)[describeEnum(colorType)];
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
      colorTheme: colorTheme,
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
  headerButtonBackgroundTopHover,
  headerButtonBackgroundBottomHover,
  headerButtonBorder,
  headerButtonPrimary,
  headerSwitcherTabPrimary,
  headerSwitcherTabBackground,
  headerSwitcherTabBorder,
}

enum GtkColorTheme {
  adwaita,
  system,
}

Map<String, Color> _system(GnomeTheme theme) {
  return {
    'windowControlIconColor':
        theme.buttonFg != null ? theme.buttonFg! : const Color(0xFFF9F8F8),
    'canvas': theme.themeBgColor != null
        ? theme.themeBgColor!
        : const Color(0xFFF9F8F8),
    'headerBarBackgroundTop': theme.themeBgColor != null
        ? theme.themeBgColor!
        : const Color(0xFFF9F8F8),
    'headerBarBackgroundBottom': theme.themeBgColor != null
        ? theme.themeBgColor!
        : const Color(0xFFF9F8F8),
    'headerBarTopBorder':
        theme.border != null ? theme.border! : const Color(0xFFF9F8F8),
    'headerBarBottomBorder':
        theme.border != null ? theme.border! : const Color(0xFFF9F8F8),
    'headerButtonBackgroundTop':
        theme.buttonFg != null ? theme.buttonFg! : const Color(0xFFF9F8F8),
    'headerButtonBackgroundBottom':
        theme.buttonFg != null ? theme.buttonFg! : const Color(0xFFF9F8F8),
    'headerButtonBackgroundTopHover': theme.themeSelectedBG != null
        ? theme.themeSelectedBG!.withOpacity(0.2)
        : const Color(0xFFF9F8F8),
    'headerButtonBackgroundBottomHover': theme.themeSelectedBG != null
        ? theme.themeSelectedBG!.withOpacity(0.2)
        : const Color(0xFFF9F8F8),
    'headerButtonBorder': theme.unfocusedBorder != null
        ? theme.unfocusedBorder!
        : const Color(0xFFF9F8F8),
    'headerButtonPrimary':
        theme.buttonFg != null ? theme.buttonFg! : const Color(0xFFF9F8F8),
    'headerSwitcherTabPrimary':
        theme.buttonFg != null ? theme.buttonFg! : const Color(0xFFF9F8F8),
    'headerSwitcherTabBackground': const Color(0xFFD5D1CD),
    'headerSwitcherTabBorder': const Color(0xFFCDC7C2),
  };
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
    'headerButtonBackgroundTopHover':
        isDark ? const Color(0xFF383838) : const Color(0xFFF6F5F3),
    'headerButtonBackgroundBottomHover':
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
