import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

/// Use AdwHeaderBarMinimal for HeaderBar without window_decorations package
class AdwHeaderBar extends StatelessWidget {
  /// The leading widget for the headerbar
  final Widget leading;

  /// The center widget for the headerbar
  final Widget center;

  /// The trailing widget for the headerbar
  final Widget trailing;

  /// The action to perform when minimize button is pressed
  final VoidCallback? onMinimize;

  /// The action to perform when maximize button is pressed
  final VoidCallback? onMaximize;

  /// The action to perform when close button is pressed
  final VoidCallback? onClose;

  /// The ThemeType property from windowDecoration package to use for the titlerbar/window buttons
  final dynamic themeType;

  /// The height of the headerbar
  final double height;

  /// The padding inside the headerbar
  final EdgeInsets padding;

  /// The space b/w trailing elements and titlebar
  final double titlebarSpace;

  /// Called when headerbar is dragged
  final VoidCallback? onHeaderDrag;

  /// Called when headerbar is double tapped
  final VoidCallback? onDoubleTap;

  /// Just import window decoration package and supply the windowDecor to this
  /// To make a custom button use below code instead
  /// ```
  /// (name, type, onPressed) => RawDecoratedWindowButton(
  ///   name: name,
  ///   type: type,
  ///   onPressed: onPressed,
  /// )
  /// ```
  final Widget Function(String name, dynamic type, VoidCallback onPressed) windowDecor;

  const AdwHeaderBar({
    Key? key,
    required this.windowDecor,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailing = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    this.themeType,
    this.onMinimize,
    this.onMaximize,
    this.onClose,
  }) : super(key: key);

  AdwHeaderBar.bitsdojo({
    Key? key,

    /// The appWindow object from bitsdojo_window package
    required appWindow,
    required this.windowDecor,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailing = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    this.themeType,
    bool showMinimize = true,
    bool showMaximize = true,
    bool showClose = true,
  })  : onHeaderDrag = appWindow?.startDragging,
        onDoubleTap = appWindow?.maximizeOrRestore,
        onMinimize = showMinimize ? appWindow?.minimize : null,
        onMaximize = showMaximize ? appWindow?.maximizeOrRestore : null,
        onClose = showClose ? appWindow?.close : null,
        super(key: key);

  AdwHeaderBar.nativeshell({
    Key? key,

    /// The Window.of(context) object from nativeshell package
    required window,
    required this.windowDecor,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailing = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    this.themeType,
    bool showMinimize = true,
    bool showMaximize = true,
    bool showClose = true,
  })  : onHeaderDrag = window?.performDrag,
        onDoubleTap = null,
        onMinimize = showMinimize ? null : null,
        onMaximize = showMaximize ? null : null,
        onClose = showClose ? window.close : null,
        super(key: key);

  bool get hasWindowControls => onClose != null || onMinimize != null || onMaximize != null;

  @override
  Widget build(BuildContext context) {
    return AdwHeaderBarMinimal(
      onDoubleTap: onDoubleTap,
      onHeaderDrag: onHeaderDrag,
      leading: leading,
      center: center,
      trailing: trailing,
      padding: padding,
      titlebarSpace: titlebarSpace,
      height: height,
      closeBtn: onClose != null
          ? windowDecor(
              'close',
              themeType,
              onClose!,
            )
          : null,
      maximizeBtn: onMaximize != null
          ? windowDecor(
              'maximize',
              themeType,
              onMaximize!,
            )
          : null,
      minimizeBtn: onMinimize != null
          ? windowDecor(
              'minimize',
              themeType,
              onMinimize!,
            )
          : null,
    );
  }
}
