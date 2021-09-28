import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:dbus/dbus.dart';
import 'package:gsettings/gsettings.dart';
import 'package:from_css_color/from_css_color.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdgdir;

class GnomeTheme {
  String contents = "";

  late String theme = '';
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

  late ThemeData themeData;

  GnomeTheme() {
    themeData = adwaita();
    // loadFromFile();
    // parse();
  }

  Future loadFromFile() async {
    final settings = GSettings('org.gnome.desktop.interface');
    theme = ((await settings.get('gtk-theme')) as DBusString).value;
    String folderPath = "";
    String path1 = "/usr/share/themes/" + theme;
    String path2 =
        xdgdir.configHome.path.replaceAll('config', 'themes/') + theme;
    String path3 = "${xdgdir.dataHome.path}/themes/" + theme;
    if (Directory(path1).existsSync()) {
      folderPath = path1;
    } else if (Directory(path2).existsSync()) {
      folderPath = path2;
    } else if (Directory(path3).existsSync()) {
      folderPath = path3;
    } else {
      return;
    }
    File file = File(folderPath + "/gtk-3.0/gtk.css");
    if (await file.exists()) {
      contents = await file.readAsString();
    }
  }

  ThemeData adwaita() {
    themeData = ThemeData(
      brightness: Brightness.light,
    );
    return themeData;
  }

  ThemeData data() {
    themeData = ThemeData(
      iconTheme: IconThemeData(color: textColor),
      brightness: textColor != null
          ? textColor!.computeLuminance() < 0.5
              ? Brightness.light
              : Brightness.dark
          : null,
      canvasColor: themeBgColor,
      textSelectionTheme: TextSelectionThemeData(cursorColor: textColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: buttonFg, onPrimary: textColor)),
      textTheme: TextTheme(
          bodyText2: TextStyle(color: textColor),
          bodyText1: TextStyle(color: textColor)),
      primaryColor: themeBaseColor,
    );
    themeData = themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(secondary: textColor));
    return themeData;
  }

  /// Get standard gtk color define
  Color? getBaseColor(String colorName) {
    String demand = "(@define-color " + colorName + " )(.*);";
    RegExp exp = RegExp(demand);

    RegExpMatch? matches = exp.firstMatch(contents);
    String? color = matches?.group(2).toString();
    if (color != null) {
      try {
        return fromCssColor(color);
      } catch (e) {
        debugPrint(e.toString());
      }
    }
    return null;
  }

  void parse() {
    themeBgColor = getBaseColor("theme_base_color");
    textColor = getBaseColor("theme_text_color") ??
        (theme.contains('dark') ||
                (themeBgColor != null &&
                    themeBgColor!.computeLuminance() <= 0.5)
            ? Colors.white
            : Colors.black);
    buttonFg = getBaseColor("button_fg_color");
    themeBaseColor = getBaseColor("theme_base_color");
    insensitiveBgColor = getBaseColor("insensitive_bg_color");
    unfocusedBorder = getBaseColor("unfocused_borders");
    border = getBaseColor("borders");
    themeSelectedBG = getBaseColor("theme_selected_bg_color");
    textSelectedFG = getBaseColor("theme_selected_fg_color");

    buttonFg ??= themeBgColor;
    data();
  }
}

Color getGtkColor({
  required GnomeTheme gnomeTheme,
  required GtkColorType colorType,
  required bool isDark,
}) {
  return _system(gnomeTheme)[describeEnum(colorType)] ??
      _adwaita(isDark)[describeEnum(colorType)]!;
}

Color getAdaptiveGtkColor(
  BuildContext context, {
  required GnomeTheme gnomeTheme,
  required GtkColorType colorType,
}) =>
    getGtkColor(
      gnomeTheme: gnomeTheme,
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

Map<String, Color?> _system(GnomeTheme theme) {
  return {
    'windowControlIconColor': theme.buttonFg,
    'canvas': theme.themeBgColor,
    'headerBarBackgroundTop': theme.themeBgColor,
    'headerBarBackgroundBottom': theme.themeBgColor,
    'headerBarTopBorder': theme.border,
    'headerBarBottomBorder': theme.border,
    'headerButtonBackgroundTop': theme.buttonFg,
    'headerButtonBackgroundBottom': theme.buttonFg,
    'headerButtonBackgroundTopHover': theme.themeSelectedBG?.withOpacity(0.2),
    'headerButtonBackgroundBottomHover':
        theme.themeSelectedBG?.withOpacity(0.2),
    'headerButtonBorder': theme.unfocusedBorder,
    'headerButtonPrimary': theme.buttonFg,
    'headerSwitcherTabPrimary': theme.buttonFg,
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
