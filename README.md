## GTK ❤️ Flutter

[![Pub.dev](https://img.shields.io/pub/v/gtk.svg)](https://pub.dev/packages/gtk)
[![License](https://img.shields.io/github/license/prateekmedia/gtk-flutter?color=indigo)](LICENSE)
[![Maintainer](https://img.shields.io/badge/Maintainer-prateekmedia-informational)](https://github.com/prateekmedia)

Unofficial implementation of GTK Widgets and libadwaita in Flutter. Based on the GNOME Human Interface Guidelines.

![GTK+Flutter example screenshot](https://user-images.githubusercontent.com/41370460/136773750-eb2a6dcc-bc7b-4054-9207-35fcffd05867.jpg)

### Features

- Libadwaita colors implemented
- Various GTK widgets ported to flutter
- Compatible with [various packages](#additional-information)

### Usage

- Wrap your `MaterialApp` / `CupertinoApp` with `GnomeTheme`
- To get `ThemeData` for `MaterialApp` use `GnomeTheme.of(context).themeData`.
- To get color from theme you can use `GnomeTheme.of(context).[color]` like `GnomeTheme.of(context).tiles`.
- If you want custom titlebar then you can follow the steps for that on [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) package.
- Following Widgets are currently ported to flutter:
    - `GtkHeaderBar`
    - `GtkHeaderBarMinimal`
    - `GtkHeaderButton`
    - `GtkPopupMenu`
    - `GtkSidebar`
    - `GtkTwoPane`
    - `GtkViewSwitcher`
    - `GtkViewSwitcherTab`


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