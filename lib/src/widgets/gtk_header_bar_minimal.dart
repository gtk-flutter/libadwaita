import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';

class GtkHeaderBarMinimal extends StatelessWidget {
  /// The Theme by which the color scheme
  /// of the HeaderBar will be based of
  final GnomeTheme gnomeTheme;

  /// The leading widget for the headerbar
  final Widget leading;

  /// The center widget for the headerbar
  final Widget center;

  /// The trailing widget for the headerbar
  final Widget trailing;

  final Widget? minimizeBtn;

  final Widget? maximizeBtn;

  final Widget? closeBtn;

  // final GtkColorTheme systemTheme;

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

  const GtkHeaderBarMinimal({
    Key? key,
    required this.gnomeTheme,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailing = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    this.minimizeBtn,
    this.maximizeBtn,
    this.closeBtn,
  }) : super(key: key);

  GtkHeaderBarMinimal.bitsdojo({
    Key? key,

    /// The appWindow object from bitsdojo_window package
    required appWindow,
    required this.gnomeTheme,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailing = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    Widget Function(VoidCallback onTap)? minimizeBtn,
    Widget Function(VoidCallback onTap)? maximizeBtn,
    Widget Function(VoidCallback onTap)? closeBtn,
  })  : onHeaderDrag = appWindow?.startDragging,
        onDoubleTap = appWindow?.maximizeOrRestore,
        minimizeBtn = minimizeBtn?.call(appWindow?.minimize),
        maximizeBtn = maximizeBtn?.call(appWindow?.maximizeOrRestore),
        closeBtn = closeBtn?.call(appWindow?.close),
        super(key: key);

  GtkHeaderBarMinimal.nativeshell({
    Key? key,

    /// The Window.of(context) object from nativeshell package
    required window,
    required this.gnomeTheme,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailing = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    Widget Function(VoidCallback onTap)? minimizeBtn,
    Widget Function(VoidCallback onTap)? maximizeBtn,
    Widget Function(VoidCallback onTap)? closeBtn,
  })  : onHeaderDrag = window?.performDrag,
        onDoubleTap = null,
        minimizeBtn = null,
        maximizeBtn = null,
        closeBtn = closeBtn?.call(window.close),
        super(key: key);

  bool get hasWindowControls =>
      closeBtn != null || minimizeBtn != null || maximizeBtn != null;

  @override
  Widget build(BuildContext context) {
    Color? border = gnomeTheme.border;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) => onHeaderDrag?.call(),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  getAdaptiveGtkColor(
                    context,
                    gnomeTheme: gnomeTheme,
                    colorType: GtkColorType.headerBarBackgroundTop,
                  ),
                  getAdaptiveGtkColor(
                    context,
                    gnomeTheme: gnomeTheme,
                    colorType: GtkColorType.headerBarBackgroundBottom,
                  ),
                ]),
            border: Border(
              top: BorderSide(
                color: Theme.of(context).canvasColor,
              ),
              bottom: BorderSide(
                color: border ?? Theme.of(context).canvasColor,
              ),
            ),
          ),
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onDoubleTap: onDoubleTap,
              ),
              NavigationToolbar(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    leading,
                  ],
                ),
                middle: center,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    trailing,
                    if (hasWindowControls) SizedBox(width: titlebarSpace),
                    ...[
                      if (minimizeBtn != null) minimizeBtn!,
                      if (maximizeBtn != null) maximizeBtn!,
                      if (closeBtn != null) closeBtn!,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
