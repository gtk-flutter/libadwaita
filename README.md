## GTK ❤️ Flutter

Unofficial implementation of GTK Widgets, themes and titlebar buttons in Flutter. Based on the GNOME Human Interface Guidelines.

![GTK+Flutter example screenshot](https://user-images.githubusercontent.com/41370460/135214049-fc40e042-96ac-4386-aece-df4998ae0ef7.jpg)

### Features

- Adwaita style Colors and icons
- Various GTK widgets ported to flutter
- Picks up system theme from current gtk-3.0 theme
- Provides various window decorations / titlebar buttons for header bar

### Usage

- To get color from theme you can use either `getGtkColor` function or `getAdaptiveGtkColor` function.
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