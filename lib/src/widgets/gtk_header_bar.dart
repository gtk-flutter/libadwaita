import 'package:flutter/material.dart';
import 'package:window_decorations/window_decorations.dart';
import '../utils/utils.dart';

class GtkHeaderBar extends StatelessWidget {
  /// appWindow object from bitsdojo_window, can be null
  final dynamic appWindow;

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

  const GtkHeaderBar({
    Key? key,
    required this.appWindow,
    this.leading = const SizedBox(),
    this.center = const SizedBox(),
    this.trailling = const SizedBox(),
    this.themeType = ThemeType.auto,
    this.systemTheme = GtkColorTheme.adwaita,
    this.onMinimize,
    this.onMaximize,
    this.onClose,
  }) : super(key: key);

  bool get hasWindowControls =>
      onClose != null || onMinimize != null || onMaximize != null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (_) => appWindow?.startDragging(),
      onDoubleTap: appWindow?.maximizeOrRestore,
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
          height: 47,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    leading,
                    Row(
                      children: [
                        trailling,
                        Row(
                          children: [
                            if (hasWindowControls) const SizedBox(width: 16),
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
                            ]
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              center,
            ],
          ),
        ),
      ),
    );
  }
}
