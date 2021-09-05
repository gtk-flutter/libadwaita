import 'package:flutter/material.dart';
import 'package:window_decorations/window_decorations.dart';
import '../utils/utils.dart';

class GtkHeaderBar extends StatelessWidget {
  /// The leading widget for the headerbar
  final Widget leading;

  /// The center widget for the headerbar
  final Widget center;

  /// The trailing widget for the headerbar
  final Widget trailling;

  /// The action to perform when minimize button is pressed
  final VoidCallback? onMinimize;

  /// The action to perform when maximize button is pressed
  final VoidCallback? onMaximize;

  /// The action to perform when close button is pressed
  final VoidCallback? onClose;

  /// The theme to use for the titlerbar/window buttons
  final ThemeType themeType;

  final GtkColorTheme systemTheme;

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

  const GtkHeaderBar({
    Key? key,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailling = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    this.themeType = ThemeType.auto,
    this.systemTheme = GtkColorTheme.adwaita,
    this.onMinimize,
    this.onMaximize,
    this.onClose,
  }) : super(key: key);

  GtkHeaderBar.bitsdojo({
    Key? key,

    /// The appWindow object from bitsdojo_window package
    required appWindow,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailling = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    this.themeType = ThemeType.auto,
    this.systemTheme = GtkColorTheme.adwaita,
    bool showMinimize = true,
    bool showMaximize = true,
    bool showClose = true,
  })  : onHeaderDrag = appWindow?.startDragging,
        onDoubleTap = appWindow?.maximizeOrRestore,
        onMinimize = showMinimize ? appWindow?.minimize : null,
        onMaximize = showMaximize ? appWindow?.maximizeOrRestore : null,
        onClose = showClose ? appWindow?.close : null,
        super(key: key);

  GtkHeaderBar.nativeshell({
    Key? key,

    /// The Window.of(context) object from nativeshell package
    required window,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailling = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 47,
    this.themeType = ThemeType.auto,
    this.systemTheme = GtkColorTheme.adwaita,
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
                  colorType: GtkColorType.headerBarBackgroundTop,
                  colorTheme: systemTheme,
                ),
                getAdaptiveGtkColor(
                  context,
                  colorType: GtkColorType.headerBarBackgroundBottom,
                  colorTheme: systemTheme,
                ),
              ],
            ),
            border: Border(
              top: BorderSide(
                color: getAdaptiveGtkColor(
                  context,
                  colorType: GtkColorType.headerBarTopBorder,
                  colorTheme: systemTheme,
                ),
              ),
              bottom: BorderSide(
                color: getAdaptiveGtkColor(
                  context,
                  colorType: GtkColorType.headerBarBottomBorder,
                  colorTheme: systemTheme,
                ),
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
                leading: leading,
                middle: center,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    trailling,
                    if (hasWindowControls) SizedBox(width: titlebarSpace),
                    ...[
                      if (onMinimize != null)
                        DecoratedMinimizeButton(
                          type: themeType,
                          onPressed: onMinimize,
                        ),
                      if (onMaximize != null)
                        DecoratedMaximizeButton(
                          type: themeType,
                          onPressed: onMaximize,
                        ),
                      if (onClose != null)
                        DecoratedCloseButton(
                          type: themeType,
                          onPressed: onClose,
                        ),
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
