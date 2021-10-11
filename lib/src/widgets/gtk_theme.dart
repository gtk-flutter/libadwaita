import 'package:flutter/material.dart';

class GnomeTheme extends InheritedWidget {
  final ValueNotifier<Color> primary = ValueNotifier<Color>(Colors.blue);

  /// List rows, tiles
  final Color tiles;

  /// Menus, popovers
  final Color menus;

  /// Header bars, active tabs, message dialogs, sidebars
  final Color sidebars;

  /// Text, icons color
  final Color textColor;

  /// Foreground areas, borders
  final Color fgColor;

  /// Background areas
  final Color bgColor;

  /// Inactive tabs
  final Color inactiveTabs;

  final bool isDark;

  late final Color border = fgColor.withOpacity(0.1);

  late final ThemeData themeData = ThemeData(
    primaryColor: primary.value,
    canvasColor: bgColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: primary.value,
        primary: primary.value,
        brightness: isDark ? Brightness.dark : Brightness.light),
  );

  static GnomeTheme of(BuildContext context) {
    final GnomeTheme? result =
        context.dependOnInheritedWidgetOfExactType<GnomeTheme>();
    assert(result != null,
        'No GnomeTheme found in context, Please wrap your MaterialApp / CupertinoApp with GnomeTheme');
    return result!;
  }

  GnomeTheme({
    Key? key,
    required this.isDark,
    required Widget Function(BuildContext context) builder,
  })  : tiles = LibAdwaita().tiles[isDark ? 1 : 0],
        menus = LibAdwaita().menus[isDark ? 1 : 0],
        sidebars = LibAdwaita().sidebars[isDark ? 1 : 0],
        textColor = LibAdwaita().textColor[isDark ? 1 : 0],
        fgColor = LibAdwaita().fgColor[isDark ? 1 : 0],
        bgColor = LibAdwaita().bgColor[isDark ? 1 : 0],
        inactiveTabs = LibAdwaita().inactiveTabs[isDark ? 1 : 0],
        super(key: key, child: Builder(builder: builder));

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget.child != child;
  }
}

extension _ColorExtension on String {
  Color get fromHex => Color(int.parse('FF${toString()}', radix: 16));
}

class LibAdwaita {
  /// Follows the pattern of ```<List>[Light Color, Dark Color]```
  /// Colors taken from https://gitlab.gnome.org/GNOME/libadwaita/-/issues/267,
  /// for more info see https://gitlab.gnome.org/GNOME/libadwaita/-/blob/main/src/stylesheet/_colors.scss

  final List<Color> tiles = ['ffffff'.fromHex, '303030'.fromHex];
  final List<Color> menus = ['ffffff'.fromHex, '383838'.fromHex];
  final List<Color> sidebars = ['ebebeb'.fromHex, '303030'.fromHex];
  final List<Color> textColor = [Colors.black, Colors.white];
  final List<Color> fgColor = [Colors.black26, Colors.white];
  final List<Color> bgColor = ['fafafa'.fromHex, '242424'.fromHex];
  final List<Color> inactiveTabs = ['e5e5e5'.fromHex, '292929'.fromHex];
}

enum GtkColorType { primary, tiles, menus, sidebar, bgAreas, inactiveTabs }
