## GTK ❤️ Flutter

[![Pub.dev](https://img.shields.io/pub/v/gtk.svg)](https://pub.dev/packages/gtk)
[![License](https://img.shields.io/github/license/prateekmedia/gtk-flutter?color=indigo)](LICENSE)
[![Maintainer](https://img.shields.io/badge/Maintainer-prateekmedia-informational)](https://github.com/prateekmedia)

Unofficial implementation of GTK Widgets and libadwaita in Flutter. Based on the GNOME Human Interface Guidelines.

![GTK+Flutter example screenshot](https://user-images.githubusercontent.com/41370460/137439130-571c6d74-b3f5-4f01-8c11-3ea8de562dd3.jpg)

**NOTE:** For getting colors from gtk 3.0 theme use version [`<=0.9.8+1`](https://pub.dev/packages/gtk/versions/0.9.8+1)

### Features

- Libadwaita colors implemented
- Various GTK widgets ported to flutter
- Compatible with [various packages](#additional-information)

### Usage

- To get color from theme you can use `Theme.of(context).[color]` like usual. E.g. `Theme.of(context).tiles`.
- Following colors are available:
    - `tiles` - List rows, tiles
    - `menus`- Menus, popovers
    - `sidebars` - Header bars, active tabs, message dialogs, sidebars
    - `viewSwitcher` - View switcher
    - `textColor` - Text, icons color
    - `fgColor` - Foreground areas, borders
    - `bgColor` - Background areas
    - `inactiveTabs` - Inactive tabs
    - `border` - Border
- If you want custom titlebar then you can follow the steps for that on [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) package.
- Following Widgets are currently ported to flutter:
    - `GtkContainer`
    - `GtkHeaderBar`
    - `GtkHeaderBarMinimal`
    - `GtkHeaderButton`
    - `GtkPopupMenu`
    - `GtkSidebar`
    - `GtkTwoPane`
    - `GtkViewSwitcher`
    - `GtkViewSwitcherTab`

See the example app in the `example` folder.

### Additional information

This package is dependent on
- [`popover`](https://pub.dev/packages/popover) for GtkPopover.
- [`window_decorations`](https://pub.dev/packages/window_decorations) for Window Decorations (doesn't needed if you use `GtkHeaderBarMinimal`)

Optional packages to use with this package:
- [`adwaita_icons`](https://pub.dev/packages/adwaita_icons) for Adwaita Icons
- [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) for better look and feel with custom GtkHeaderBar.bitsdojo
- [`nativeshell`](https://pub.dev/packages/nativeshell) for better look and feel with custom GtkHeaderBar.nativeshell

[Classic API Docs](https://pub.dev/documentation/gtk/latest/)

### License

`LGPL v3 / GNU LESSER GENERAL PUBLIC LICENSE v3`

TLDR;
- You are free to use [this](https://pub.dev/packages/gtk) package in whatever app you want,
- If you improve the package then you should submit your patches / improvements to [this](https://github.com/prateekmedia/gtk-flutter) repository.