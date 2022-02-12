# Examples for libadwaita flutter package

## Demo App
[Here]('https://github.com/gtk-flutter/libadwaita/tree/main/example') is a demo app made with libadwaita package.

## Minimal [`bitsdojo_window`](https://pub.dev/packages/bitsdojo_window) usage:
```yaml
#pubspec.yaml
dependencies:
  adwaita:
  bitsdojo_window:
  libadwaita:
```

```dart
// main.dart

import 'package:adwaita/adwaita.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdwScaffold(
      headerbar: (_) => AdwHeaderBar.bitsdojo(
        appWindow: appWindow,
        start: const [
          AdwHeaderButton(
            icon: Icon(Icons.nightlight_round, size: 15),
          ),
        ],
        title: const Text('Bitsdojo Window'),
      ),
      body: const Center(
        child: Text('Welcome to Bitsdojo Window Example!'),
      ),
    );
  }
}
```

## Minimal [`nativeshell`](https://pub.dev/packages/nativeshell) usage:
```yaml
#pubspec.yaml
dependencies:
  adwaita:
  libadwaita:
  nativeshell:
```

```dart
// main.dart

import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:nativeshell/nativeshell.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      home: WindowWidget(
        onCreateState: (dynamic _) {
          WindowState? state;
          return state ??= MainWindowState();
        },
      ),
    );
  }
}

class MainWindowState extends WindowState {
  @override
  Future<void> initializeWindow(Size contentSize) async {
    await window.setStyle(WindowStyle(frame: WindowFrame.noTitle));
    await window.show();
  }

  @override
  WindowSizingMode get windowSizingMode =>
      WindowSizingMode.atLeastIntrinsicSize;

  @override
  Widget build(BuildContext context) {
    return WindowLayoutProbe(
      child: AdwScaffold(
        headerbar: (_) => AdwHeaderBar.nativeshell(
          window: window,
          start: const [
            AdwHeaderButton(
              icon: Icon(Icons.nightlight_round, size: 15),
            ),
          ],
          title: const Text('Nativeshell'),
        ),
        body: const Center(
          child: Text('Welcome to NativeShell Example!'),
        ),
      ),
    );
  }
}
```

## Minimal [`window_decorations`](https://pub.dev/packages/window_decorations) usage:
```yaml
#pubspec.yaml
dependencies:
  adwaita:
  libadwaita:
  window_decorations:
```

```dart
// main.dart

import 'package:adwaita/adwaita.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:window_decorations/window_decorations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AdwScaffold(
      headerbar: (_) => AdwHeaderBar(
        windowDecor: windowDecor,
        onClose: () {},
        onMaximize: () {},
        onMinimize: () {},
        start: const [
          AdwHeaderButton(
            icon: Icon(Icons.nightlight_round, size: 15),
          ),
        ],
        title: const Text('Window Decorations'),
      ),
      body: const Center(
        child: Text('Welcome to Window Decorations Example!'),
      ),
    );
  }
}
```