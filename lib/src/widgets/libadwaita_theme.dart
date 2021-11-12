import 'package:flutter/material.dart';

extension _ColorExtension on String {
  Color get fromHex => Color(int.parse('FF${toString()}', radix: 16));
}

Color _tiles(Brightness brightness) =>
    brightness == Brightness.light ? 'ffffff'.fromHex : '303030'.fromHex;

Color _menus(Brightness brightness) =>
    brightness == Brightness.light ? 'ffffff'.fromHex : '383838'.fromHex;

Color _sidebars(Brightness brightness) =>
    brightness == Brightness.light ? 'ebebeb'.fromHex : '303030'.fromHex;

Color _viewSwitcher(Brightness brightness) =>
    brightness == Brightness.light ? 'd9d9d9'.fromHex : '444444'.fromHex;

Color _textColor(Brightness brightness) =>
    brightness == Brightness.light ? Colors.black : Colors.white;

Color _fgColor(Brightness brightness) =>
    brightness == Brightness.light ? Colors.black26 : Colors.white;

Color _bgColor(Brightness brightness) =>
    brightness == Brightness.light ? 'fafafa'.fromHex : '242424'.fromHex;

Color _inactiveTabs(Brightness brightness) =>
    brightness == Brightness.light ? 'e5e5e5'.fromHex : '292929'.fromHex;

Color _border(Brightness brightness) => brightness == Brightness.light
    ? Colors.black26.withOpacity(0.1)
    : Colors.white.withOpacity(0.1);

ThemeData _adwaitaTheme(Brightness brightness) => ThemeData(
      brightness: brightness,
      canvasColor: _bgColor(brightness),
    );

ThemeData get adwaitaLight => _adwaitaTheme(Brightness.light);
ThemeData get adwaitaDark => _adwaitaTheme(Brightness.dark);

extension LibAdwaitaTheme on ThemeData {
  /// For List rows, tiles
  Color get tiles => _tiles(brightness);

  /// For Menus, popovers
  Color get menus => _menus(brightness);

  /// For Header bars, active tabs, message dialogs, sidebars
  Color get sidebars => _sidebars(brightness);

  /// For View switcher
  Color get viewSwitcher => _viewSwitcher(brightness);

  /// For Text, icons color
  Color get textColor => _textColor(brightness);

  /// For Foreground areas, borders
  Color get fgColor => _fgColor(brightness);

  /// For Background areas
  Color get bgColor => _bgColor(brightness);

  /// For Inactive tabs
  Color get inactiveTabs => _inactiveTabs(brightness);
  // Border for the elements of your GTK app
  Color get border => _border(brightness);
}
