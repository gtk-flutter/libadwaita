import 'package:flutter/material.dart';

class GnomeTheme extends InheritedWidget {
  final ValueNotifier<Color> primary = ValueNotifier<Color>(Colors.blue);
  final Color tiles;
  final Color menus;
  final Color sidebars;
  final Color textColor;
  final Color fgColor;
  final Color bgColor;
  final Color inactiveTabs;
  final bool isDark;

  late final Color border = fgColor.withOpacity(isDark ? 0.5 : 0.2 * 0.5);
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
        'No GnomeTheme found in context, Please wrap your Material / Cupertino App with GnomeTheme');
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

  /// List rows, tiles
  final List<Color> tiles = ['ffffff'.fromHex, '303030'.fromHex];

  /// Menus, popovers
  final List<Color> menus = ['ffffff'.fromHex, '383838'.fromHex];

  /// Header bars, active tabs, message dialogs, sidebars
  final List<Color> sidebars = ['ebebeb'.fromHex, '303030'.fromHex];

  final List<Color> textColor = [Colors.black, Colors.white];

  /// Foreground areas, borders
  final List<Color> fgColor = [Colors.black26, Colors.white];

  /// Background areas
  final List<Color> bgColor = ['fafafa'.fromHex, '242424'.fromHex];

  /// Inactive tabs
  final List<Color> inactiveTabs = ['e5e5e5'.fromHex, '292929'.fromHex];
}

enum GtkColorType { primary, tiles, menus, sidebar, bgAreas, inactiveTabs }
