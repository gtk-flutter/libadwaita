import 'package:flutter/material.dart';

extension _ColorExtension on String {
  Color get fromHex => Color(int.parse('FF${toString()}', radix: 16));
}

extension LibAdwaitaTheme on ThemeData {
  Color get tiles =>
      brightness == Brightness.light ? 'ffffff'.fromHex : '303030'.fromHex;
  Color get menus =>
      brightness == Brightness.light ? 'ffffff'.fromHex : '383838'.fromHex;
  Color get sidebars =>
      brightness == Brightness.light ? 'ebebeb'.fromHex : '303030'.fromHex;
  Color get viewSwitcher =>
      brightness == Brightness.light ? 'd9d9d9'.fromHex : '444444'.fromHex;
  Color get textColor =>
      brightness == Brightness.light ? Colors.black : Colors.white;
  Color get fgColor =>
      brightness == Brightness.light ? Colors.black26 : Colors.white;
  Color get bgColor =>
      brightness == Brightness.light ? 'fafafa'.fromHex : '242424'.fromHex;
  Color get inactiveTabs =>
      brightness == Brightness.light ? 'e5e5e5'.fromHex : '292929'.fromHex;
  Color get border => brightness == Brightness.light
      ? Colors.black26.withOpacity(0.1)
      : Colors.white.withOpacity(0.1);
}

enum GtkColorType { primary, tiles, menus, sidebar, bgAreas, inactiveTabs }
