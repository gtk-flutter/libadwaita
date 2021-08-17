## GTK ❤️ Flutter

Unofficial implementation of GTK Widgets, themes and titlebar buttons in Flutter. Based on the GNOME Human Interface Guidelines.

![gtk+flutter](https://user-images.githubusercontent.com/41370460/129775177-a4dcd231-0756-4062-a4a8-bef2e1f31dd1.png)

### Features

- Adwaita style Colors and icons
- Various GTK widgets ported to flutter
- Provides various window decorations / titlebar buttons for header bar

### Usage

- To get color from theme you can use either `getGtkColor` function or `getAdaptiveGtkColor` function.
- If you want custom titlebar then you can follow the steps for that on [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) package.
- Following Widgets are currently ported to flutter:  
`GtkSidebar`, `GtkHeaderBar`, `GtkHeaderButton`. `GtkPopupMenu`, `GtkTwoPane`.


### Additional information

This package is dependent on 
* [`adwaita_icons`](https://pub.dev/packages/adwaita_icons) for adwaita style icons
* [`popover`](https://pub.dev/packages/popover) for GtkPopover.
* [`window_decorations`](https://pub.dev/packages/window_decorations) for Window Decorations

[Classic API Docs](https://pub.dev/documentation/gtk/latest/)

### License

`GNU GENERAL PUBLIC LICENSE v3`