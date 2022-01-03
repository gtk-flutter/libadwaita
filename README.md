# Libadwaita ❤️ Flutter

![CI](https://github.com/gtk-flutter/libadwaita/actions/workflows/ci.yml/badge.svg)
[![GitHub Super-Linter](https://github.com/gtk-flutter/adwaita/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)

[![Pub.dev](https://img.shields.io/pub/v/libadwaita.svg)](https://pub.dev/packages/libadwaita)
[![License](https://img.shields.io/github/license/gtk-flutter/libadwaita?color=indigo)](LICENSE)
[![Maintainer](https://img.shields.io/badge/Maintainer-prateekmedia-informational)](https://github.com/prateekmedia)

Libadwaita's widgets for Flutter. Following Gnome HIG and available on all platforms.

![libadwaita example screenshot](https://user-images.githubusercontent.com/41370460/146646064-09e10e32-8635-43ed-bd9c-0ed191d30a97.png)

**NOTE:** For getting colors from gtk 3.0 theme use version [`<=0.9.8+1`](https://pub.dev/packages/gtk/versions/0.9.8+1)

## Features

- Various Libadwaita widgets ported to flutter
- Some new widgets are also available, Check example for more info
- Compatible with [various packages](#additional-information)

## Usage

- This only provides widgets, for theming you should consider [adwaita](https://pub.dev/packages/adwaita) or [yaru](https://github.com/ubuntu/yaru.dart) package.
- If you want custom titlebar then you can follow the steps for that on [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) package.
- Following Widgets are currently ported to flutter, for more info visit [libadwaita documentation](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/index.html#classes):

  - [`AdwActionRow`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.ActionRow.html)
  - [`AdwClamp`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.Clamp.html)
  - [`AdwComboRow`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.ComboRow.html)
  - [`AdwFlap`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.Flap.html)
  - [`AdwHeaderBar`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.HeaderBar.html) - use `.minimal` for using it without [`window_decorations`](https://pub.dev/packages/window_decorations) package.
  - `AdwHeaderButton` - A Header button to be used with `AdwHeaderBar*`
  - `AdwPopupMenu` - A Popup Menu button
  - [`AdwPreferencesGroup`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.PreferencesGroup.html)
  - `AdwScaffold`
  - `AdwStackSidebar` - GtkStackSidebar renamed to match the flow
  - `AdwSidebar` - To be used with `AdwStackSidebar` or `AdwFlap`
  - `AdwTextButton`
  - `AdwTextField`
  - [`AdwViewStack`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.ViewStack.html)
  - [`AdwViewSwitcher`](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/class.ViewSwitcher.html)
  - `AdwViewSwitcherTab` - Tabs for AdwViewSwitcher

See the example app in the `example` folder for more info.

## Additional information

This package is dependent on

- [adwaita](https://pub.dev/packages/adwaita) or [yaru](https://github.com/ubuntu/yaru.dart) - For theming
- [`popover`](https://pub.dev/packages/popover) for `AdwPopupMenu`.
- [`window_decorations`](https://pub.dev/packages/window_decorations) for Window Decorations (not needed if you use `AdwHeaderBarMinimal`)

Optional packages to use with this package:

- [`adwaita_icons`](https://pub.dev/packages/adwaita_icons) for Adwaita Icons
- [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) for better look and feel with custom AdwHeaderBar.bitsdojo
- [`nativeshell`](https://pub.dev/packages/nativeshell) for better look and feel with custom AdwHeaderBar.nativeshell

[Classic API Docs](https://pub.dev/documentation/libadwaita/latest/)

## License

`LGPL v3 / GNU LESSER GENERAL PUBLIC LICENSE v3`

TLDR;

- You are free to use [this](https://pub.dev/packages/libadwaita) package in whatever app you want,
- If you improve the package then you should submit your patches / improvements to [this](https://github.com/gtk-flutter/libadwaita) repository.
