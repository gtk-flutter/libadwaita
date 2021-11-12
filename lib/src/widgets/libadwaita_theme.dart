import 'package:flutter/material.dart';

extension _ColorExtension on String {
  Color get fromHex => Color(int.parse('FF${toString()}', radix: 16));
}

ThemeData adwaitaLight(BuildContext context) => ThemeData.light().copyWith(
      canvasColor: Theme.of(context).bgColor,
    );

ThemeData adwaitaDark(BuildContext context) => ThemeData.dark().copyWith(
      canvasColor: Theme.of(context).bgColor,
    );

extension LibAdwaitaTheme on ThemeData {
  /// List rows, tiles
  Color get tiles =>
      brightness == Brightness.light ? 'ffffff'.fromHex : '303030'.fromHex;

  /// Menus, popovers
  Color get menus =>
      brightness == Brightness.light ? 'ffffff'.fromHex : '383838'.fromHex;

  /// Header bars, active tabs, message dialogs, sidebars
  Color get sidebars =>
      brightness == Brightness.light ? 'ebebeb'.fromHex : '303030'.fromHex;

  /// View switcher
  Color get viewSwitcher =>
      brightness == Brightness.light ? 'd9d9d9'.fromHex : '444444'.fromHex;

  /// Text, icons color
  Color get textColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;

  /// Foreground areas, borders
  Color get fgColor =>
      brightness == Brightness.light ? Colors.black26 : Colors.white;

  /// Background areas
  Color get bgColor =>
      brightness == Brightness.light ? 'fafafa'.fromHex : '242424'.fromHex;

  /// Inactive tabs
  Color get inactiveTabs =>
      brightness == Brightness.light ? 'e5e5e5'.fromHex : '292929'.fromHex;

  Color get border => brightness == Brightness.light
      ? Colors.black26.withOpacity(0.1)
      : Colors.white.withOpacity(0.1);
}
