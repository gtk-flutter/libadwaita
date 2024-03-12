import 'package:universal_io/io.dart';

import 'package:dbus/dbus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:libadwaita/src/utils/colors.dart';
import 'package:libadwaita/src/widgets/widgets.dart';
import 'package:libadwaita_core/libadwaita_core.dart';

class HeaderBarStyle {
  const HeaderBarStyle({
    this.isTransparent = false,
    this.textStyle,
    this.height = 47,
    this.autoPositionWindowButtons = true,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 6,
    this.nativeControls = true,
  });

  /// If true, background color and border color
  /// will be transparent
  final bool isTransparent;

  /// Default text style applied to the child widget.
  final TextStyle? textStyle;

  /// The height of the headerbar
  final double height;

  /// Whether to automatically place the window buttons according to
  /// the Platform, defaults to true
  /// If false then it will follow the general Windows like window buttons
  /// placement
  final bool autoPositionWindowButtons;

  /// The padding inside the headerbar
  final EdgeInsets padding;

  /// The horizontal spacing before or after the window buttons
  final double titlebarSpace;

  /// Whether to show native controls on Windows or Mac os instead of default
  /// libadwaita buttons
  final bool nativeControls;
}

class AdwHeaderBar extends StatefulWidget {
  AdwHeaderBar({
    super.key,
    this.title,
    this.start = const [],
    this.end = const [],
    this.style = const HeaderBarStyle(),
    required AdwActions actions,
    AdwControls? controls,
  })  : closeBtn = controls != null
            ? controls.closeBtn?.call(actions.onClose)
            : AdwWindowButton(
                nativeControls: style.nativeControls,
                buttonType: WindowButtonType.close,
                onPressed: actions.onClose,
              ),
        maximizeBtn = controls != null
            ? controls.maximizeBtn?.call(actions.onMaximize)
            : AdwWindowButton(
                nativeControls: style.nativeControls,
                buttonType: WindowButtonType.maximize,
                onPressed: actions.onMaximize,
              ),
        minimizeBtn = controls != null
            ? controls.minimizeBtn?.call(actions.onMinimize)
            : AdwWindowButton(
                nativeControls: style.nativeControls,
                buttonType: WindowButtonType.minimize,
                onPressed: actions.onMinimize,
              ),
        onHeaderDrag = actions.onHeaderDrag,
        onDoubleTap = actions.onDoubleTap,
        onRightClick = actions.onRightClick;

  /// The leading widget for the headerbar
  final List<Widget> start;

  /// The center widget for the headerbar
  final Widget? title;

  /// The trailing widget for the headerbar
  final List<Widget> end;

  final Widget? minimizeBtn;

  final Widget? maximizeBtn;

  final Widget? closeBtn;

  /// Called when headerbar is dragged
  final VoidCallback? onHeaderDrag;

  /// Called when headerbar is double tapped
  final VoidCallback? onDoubleTap;

  /// Called when headerbar is right clicked
  final VoidCallback? onRightClick;

  /// Default style applied to this [AdwHeaderBar] widget.
  final HeaderBarStyle style;

  @override
  State<AdwHeaderBar> createState() => _AdwHeaderBarState();
}

class _AdwHeaderBarState extends State<AdwHeaderBar> {
  bool get hasWindowControls =>
      widget.closeBtn != null ||
      widget.minimizeBtn != null ||
      widget.maximizeBtn != null;

  late ValueNotifier<List<String>?> separator =
      !widget.style.autoPositionWindowButtons ||
              !kIsWeb &&
                  (Platform.isLinux || Platform.isWindows || Platform.isMacOS)
          ? ValueNotifier(
              ['', 'minimize,maximize,close'],
            )
          : ValueNotifier(null);

  @override
  void initState() {
    super.initState();

    if (widget.style.autoPositionWindowButtons) {
      void updateSep(String order) {
        if (!mounted) return;
        separator.value = order.split(':')
          ..map<String>(
            (e) => e
                .split(',')
                .where(
                  (element) =>
                      element == 'close' ||
                      element == 'maximize' ||
                      element == 'minimize',
                )
                .join(','),
          );
      }

      if (kIsWeb) {
        return;
      } else if (Platform.isMacOS) {
        updateSep('close,minimize,maximize:');
      } else if (Platform.isLinux) {
        final schema = GSettings('org.gnome.desktop.wm.preferences');

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          try {
            final buttonLayout =
                await schema.get('button-layout') as DBusString?;
            if (buttonLayout != null) {
              updateSep(buttonLayout.value);
            }
          } catch (e) {
            debugPrint('$e');
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final windowButtons = <String, Widget?>{
      'maximize': widget.maximizeBtn,
      'minimize': widget.minimizeBtn,
      'close': widget.closeBtn,
    };

    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        onSecondaryTap: widget.onRightClick,
        behavior: HitTestBehavior.translucent,
        onPanStart: (_) => widget.onHeaderDrag?.call(),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: !widget.style.isTransparent
                  ? Theme.of(context).appBarTheme.backgroundColor
                  : null,
              border: !widget.style.isTransparent
                  ? Border(
                      bottom: BorderSide(color: context.borderColor),
                    )
                  : null,
            ),
            height: widget.style.height,
            width: double.infinity,
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: widget.onDoubleTap,
                ),
                ValueListenableBuilder<List<String>?>(
                  valueListenable: separator,
                  builder: (context, sep, _) => DefaultTextStyle.merge(
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ).merge(widget.style.textStyle),
                    child: NavigationToolbar(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasWindowControls &&
                              sep != null &&
                              sep[0].split(',').isNotEmpty) ...[
                            SizedBox(width: widget.style.titlebarSpace),
                            for (var i in sep[0].split(','))
                              if (windowButtons[i] != null) windowButtons[i]!,
                            if (!widget.style.nativeControls ||
                                !kIsWeb && Platform.isLinux)
                              SizedBox(width: widget.style.titlebarSpace),
                          ],
                          ...widget.start.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: e,
                            ),
                          ),
                        ],
                      ),
                      middle: widget.title,
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...widget.end.map(
                            (e) => Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: e,
                            ),
                          ),
                          if (hasWindowControls &&
                              sep != null &&
                              sep[1].split(',').isNotEmpty) ...[
                            SizedBox(width: widget.style.titlebarSpace),
                            for (var i in sep[1].split(','))
                              if (windowButtons[i] != null) windowButtons[i]!,
                            if (!widget.style.nativeControls ||
                                !kIsWeb && Platform.isLinux)
                              SizedBox(width: widget.style.titlebarSpace),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
