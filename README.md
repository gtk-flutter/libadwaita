# Libadwaita ❤️ Flutter

![CI](https://github.com/gtk-flutter/libadwaita/actions/workflows/ci.yml/badge.svg)
[![GitHub Super-Linter](https://github.com/gtk-flutter/adwaita/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter)

[![Pub.dev](https://img.shields.io/pub/v/libadwaita.svg)](https://pub.dev/packages/libadwaita)
[![License](https://img.shields.io/github/license/gtk-flutter/libadwaita?color=indigo)](LICENSE)
[![Maintainer](https://img.shields.io/badge/Maintainer-prateekmedia-informational)](https://github.com/prateekmedia)

Libadwaita's widgets for Flutter. Following Gnome HIG and available on all platforms.

![libadwaita example screenshot](https://user-images.githubusercontent.com/41370460/154982398-70778cd9-b25e-410f-99bb-5804b33bfe38.png)

**NOTE:** For getting colors from gtk 3.0 theme use version [`<=0.9.8+1`](https://pub.dev/packages/gtk/versions/0.9.8+1)

## Features

- Various Libadwaita widgets ported to flutter
- Some new widgets are also available, Check example for more info
- Compatible with [various packages](#additional-information)

## Usage

- This only provides widgets, for theming you should consider [adwaita](https://pub.dev/packages/adwaita) or [yaru](https://github.com/ubuntu/yaru.dart) package.
- If you want custom titlebar then you can follow the steps for that on [`libadwaita_bitsdojo`](https://pub.dev/packages/libadwaita_bitsdojo) package.
- Here is the list of widgets imported from libadwaita library : [widgets.dart](https://github.com/gtk-flutter/libadwaita/blob/main/lib/src/widgets/widgets.dart).

See the example app in the [`example`](example) folder for more info.

## Relavant Links
- [libadwaita documentation](https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/index.html#classes)


## Additional information

### **This package works great with**

[**`adwaita`**](https://pub.dev/packages/adwaita) / [**`yaru`**](https://github.com/ubuntu/yaru.dart)  
For theming

### **Optional packages**

#### [**`adwaita_icons`**](https://pub.dev/packages/adwaita_icons)
For Adwaita Icons

#### [**`libadwaita_bitsdojo`**](https://pub.dev/packages/libadwaita_bitsdojo)
Can be used with
- `AdwHeaderBar.bitsdojo`
- `AdwHeaderBar.customBitsdojo`

Example:
```dart
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';

AdwHeaderBar.bitsdojo(
  ...
  appWindow: appWindow,
  ...
)
```

#### [**`libadwaita_searchbar`**](https://pub.dev/packages/libadwaita_searchbar)
Example:
```dart
import 'package:libadwaita_searchbar/libadwaita_searchbar.dart';

bool searchedTerm = '';

AdwSearchBar(
    onSubmitted: (str) => setState(() => searchedTerm = str),
    controller: const TextEditingController(),
)
```

#### [**`libadwaita_searchbar_ac`**](https://pub.dev/packages/libadwaita_searchbar_ac)
Example:
```dart
import 'package:libadwaita_searchbar_ac/libadwaita_searchbar_ac.dart';

bool searchedTerm = '';

AdwSearchBarAc(
    suggestions: const ['Hi', 'Hello'],
    onSubmitted: (str) => setState(() => searchedTerm = str),
    controller: const TextEditingController(),
)
```

#### [**`nativeshell`**](https://pub.dev/packages/nativeshell  )
Can be used with
- `AdwHeaderBar.nativeshell`
- `AdwHeaderBar.customNativeshell`

Example:
```dart
import 'package:nativeshell/nativeshell.dart';

AdwHeaderBar.nativeshell(
  ...
  window: Window.of(context),
  ...
)
```

#### [**`titlebar_buttons`**](https://pub.dev/packages/titlebar_buttons)
Can be used with
- `AdwHeaderBar`
- `AdwHeaderBar.bitsdojo`
- `AdwHeaderBar.nativeshell`

Example:
```dart
import 'package:titlebar_buttons/titlebar_buttons.dart';

AdwHeaderBar(
  ...
  windowDecor: windowDecor,
  ...
)
```

[Classic API Docs](https://pub.dev/documentation/libadwaita/latest/)

## License

`Mozilla Public License 2.0`

TLDR;

- You are free to use [this](https://pub.dev/packages/libadwaita) package in whatever app you want,
- If you improve the package then you should submit your patches / improvements to [this](https://github.com/gtk-flutter/libadwaita) repository.
