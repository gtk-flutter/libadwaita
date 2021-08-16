## GTK ❤️ Flutter

Unofficial implementation of GTK Widgets, themes and titlebar buttons in Flutter. Based on the GNOME Human Interface Guidelines.

### Features

- Adwaita style Colors and icons
- Various GTK widgets ported to flutter
- Provides various window decorations / titlebar buttons for header bar

### Usage

- To get color from theme you can you either `getGtkColor` function or `getAdaptiveGtkColor` function.
- If you want custom titlebar then you can follow the steps for that on [bitsdojo_window](https://pub.dev/packages/bitsdojo_window) package.
- You can use the following widgets that are ported to flutter:
`GtkSidebar`, `GtkHeaderBar`, `GtkHeaderButton`. `GtkPopupMenu`, `GtkTwoPane`.


### Additional information

This package is dependent on 
* [`adwaita_icons`](https://pub.dev/packages/adwaita_icons) for adwaita style icons
* [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) for headerbar related function
* [`popover`](https://pub.dev/packages/popover) for GtkPopover.
* [`window_decorations`](https://pub.dev/packages/window_decorations) for Window Decorations

[Classic API Docs](https://pub.dev/documentation/gtk/latest/)

### License

`GNU GENERAL PUBLIC LICENSE v3`