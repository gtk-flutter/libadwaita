## GTK ❤️ Flutter

Unofficial implementation of GTK Widgets, themes and titlebar buttons in Flutter. Based on the GNOME Human Interface Guidelines.

![GTK+Flutter example screenshot](https://user-images.githubusercontent.com/41370460/130322523-890fdccb-94f0-443c-9e6d-18e571827667.png)

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

License is subject to change as this provides core ui elements which are required for any kind of application, if it will then it will probably change to `LGPL`.