// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gsettings/gsettings.dart';
import 'package:libadwaita/libadwaita.dart';

enum _ButtonType { close, maximize, minimize }

class AdwHeaderBar extends StatefulWidget {
  /// If you use with window_decorations
  /// If you don't want that. use AdwHeaderBar.minimal*
  AdwHeaderBar({
    Key? key,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    VoidCallback? onMinimize,
    VoidCallback? onMaximize,
    VoidCallback? onClose,
  })  : closeBtn = _WindowButtonBuilder(
          buttonType: _ButtonType.close,
          onPressed: onClose,
        ),
        maximizeBtn = _WindowButtonBuilder(
          onPressed: onMaximize,
          buttonType: _ButtonType.maximize,
        ),
        minimizeBtn = _WindowButtonBuilder(
          onPressed: onMinimize,
          buttonType: _ButtonType.minimize,
        ),
        super(key: key);

  AdwHeaderBar.windowDecor({
    Key? key,
    required Widget Function(
      String name,
      dynamic type,
      void Function()? onPressed,
    )
        windowDecor,
    dynamic themeType,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    VoidCallback? onMinimize,
    VoidCallback? onMaximize,
    VoidCallback? onClose,
  })  : closeBtn = onClose != null
            ? windowDecor(
                'close',
                themeType,
                onClose,
              )
            : null,
        maximizeBtn = onMaximize != null
            ? windowDecor(
                'maximize',
                themeType,
                onMaximize,
              )
            : null,
        minimizeBtn = onMinimize != null
            ? windowDecor(
                'minimize',
                themeType,
                onMinimize,
              )
            : null,
        super(key: key);

  const AdwHeaderBar.custom({
    Key? key,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    this.minimizeBtn,
    this.maximizeBtn,
    this.closeBtn,
  }) : super(key: key);

  AdwHeaderBar.bitsdojo({
    Key? key,

    /// The appWindow object from bitsdojo_window package
    required dynamic appWindow,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    bool showMinimize = true,
    bool showMaximize = true,
    bool showClose = true,
  })  : closeBtn = showClose
            ? _WindowButtonBuilder(
                onPressed: appWindow?.close as void Function()?,
                buttonType: _ButtonType.close,
              )
            : null,
        maximizeBtn = showMaximize
            ? _WindowButtonBuilder(
                onPressed: appWindow?.maximize as void Function()?,
                buttonType: _ButtonType.maximize,
              )
            : null,
        minimizeBtn = showMinimize
            ? _WindowButtonBuilder(
                onPressed: appWindow?.minimize as void Function()?,
                buttonType: _ButtonType.minimize,
              )
            : null,
        onHeaderDrag = appWindow?.startDragging as void Function()?,
        onDoubleTap = appWindow?.maximizeOrRestore as void Function()?,
        super(key: key);

  AdwHeaderBar.windowDecorBitsdojo({
    Key? key,
    required Widget Function(
      String name,
      dynamic type,
      void Function()? onPressed,
    )
        windowDecor,
    dynamic themeType,

    /// The appWindow object from bitsdojo_window package
    required dynamic appWindow,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    bool showMinimize = true,
    bool showMaximize = true,
    bool showClose = true,
  })  : closeBtn = windowDecor(
          'close',
          themeType,
          showClose ? appWindow?.close as void Function()? : null,
        ),
        maximizeBtn = windowDecor(
          'maximize',
          themeType,
          showMaximize ? appWindow?.maximize as void Function()? : null,
        ),
        minimizeBtn = windowDecor(
          'minimize',
          themeType,
          showMinimize ? appWindow?.minimize as void Function()? : null,
        ),
        onHeaderDrag = appWindow?.startDragging as void Function()?,
        onDoubleTap = appWindow?.maximizeOrRestore as void Function()?,
        super(key: key);

  AdwHeaderBar.customBitsdojo({
    Key? key,

    /// The appWindow object from bitsdojo_window package
    required dynamic appWindow,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    Widget Function(VoidCallback onTap)? minimizeBtn,
    Widget Function(VoidCallback onTap)? maximizeBtn,
    Widget Function(VoidCallback onTap)? closeBtn,
  })  : onHeaderDrag = appWindow?.startDragging as void Function()?,
        onDoubleTap = appWindow?.maximizeOrRestore as void Function()?,
        minimizeBtn = minimizeBtn?.call(appWindow?.minimize as void Function()),
        maximizeBtn =
            maximizeBtn?.call(appWindow?.maximizeOrRestore as void Function()),
        closeBtn = closeBtn?.call(appWindow?.close as void Function()),
        super(key: key);

  AdwHeaderBar.nativeshell({
    Key? key,

    /// The Window.of(context) object from nativeshell package
    required dynamic window,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    bool showClose = true,
  })  : onHeaderDrag = window?.performDrag as void Function()?,
        onDoubleTap = null,
        minimizeBtn = null,
        maximizeBtn = null,
        closeBtn = _WindowButtonBuilder(
          onPressed: showClose ? window.close as void Function()? : null,
          buttonType: _ButtonType.close,
        ),
        super(key: key);

  AdwHeaderBar.windowDecorNativeshell({
    Key? key,
    required Widget Function(
      String name,
      dynamic type,
      void Function()? onPressed,
    )
        windowDecor,
    dynamic themeType,

    /// The Window.of(context) object from nativeshell package
    required dynamic window,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    bool showClose = true,
  })  : onHeaderDrag = window?.performDrag as void Function()?,
        onDoubleTap = null,
        minimizeBtn = null,
        maximizeBtn = null,
        closeBtn = windowDecor(
          'close',
          themeType,
          showClose ? window.close as void Function()? : null,
        ),
        super(key: key);

  AdwHeaderBar.customNativeshell({
    Key? key,

    /// The Window.of(context) object from nativeshell package
    required dynamic window,
    this.start = const [],
    this.title = const SizedBox(),
    this.end = const [],
    this.textStyle,
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    Widget Function(VoidCallback onTap)? closeBtn,
  })  : onHeaderDrag = window?.performDrag as void Function()?,
        onDoubleTap = null,
        minimizeBtn = null,
        maximizeBtn = null,
        closeBtn = closeBtn?.call(window.close as void Function()),
        super(key: key);

  /// The leading widget for the headerbar
  final List<Widget> start;

  /// The center widget for the headerbar
  final Widget title;

  /// The trailing widget for the headerbar
  final List<Widget> end;

  /// Default text style applied to the child widget.
  final TextStyle? textStyle;

  final Widget? minimizeBtn;

  final Widget? maximizeBtn;

  final Widget? closeBtn;

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

  @override
  State<AdwHeaderBar> createState() => _AdwHeaderBarState();
}

class _WindowButtonBuilder extends StatelessWidget {
  const _WindowButtonBuilder({
    Key? key,
    required this.buttonType,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final _ButtonType buttonType;

  @override
  Widget build(BuildContext context) {
    return onPressed != null
        ? AdwButton.circular(
            size: 25,
            onPressed: onPressed,
            child: Center(
              child: SvgPicture.asset(
                'packages/libadwaita/assets/icons/${buttonType.name}.svg',
                width: 16,
                height: 16,
                color: context.textColor,
              ),
            ),
            // CustomPaint(
            //   size: const Size(16, 16),
            //   painter: () {
            //     switch (buttonType) {
            //       case _ButtonType.close:
            //         return CloseWBPainter(color: context.textColor);
            //       case _ButtonType.maximize:
            //         return MaximizeWBPainter(color: context.textColor);
            //       case _ButtonType.minimize:
            //         return MinimizeWBPainter(color: context.textColor);
            //     }
            //   }(),),
          )
        : const SizedBox();
  }
}

class _AdwHeaderBarState extends State<AdwHeaderBar> {
  bool get hasWindowControls =>
      widget.closeBtn != null ||
      widget.minimizeBtn != null ||
      widget.maximizeBtn != null;

  late ValueNotifier<List<String>> seperator =
      ValueNotifier(['', 'minimize,maximize,close']);

  @override
  void initState() {
    super.initState();

    late final order = ValueNotifier<String>(':minimize,maximize,close');
    void updateSep() {
      if (mounted) {
        seperator.value = order.value.split(':');
      }
    }

    if (Platform.isLinux) {
      final buttonLayout = ValueNotifier<DBusString?>(null);
      final schema = GSettings('org.gnome.desktop.wm.preferences');
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        buttonLayout.value = await schema.get('button-layout') as DBusString;
        if (buttonLayout.value != null) {
          order.value = buttonLayout.value!.value;
        }
        updateSep();
      });
    } else if (Platform.isMacOS) {
      order.value = 'close,maximize,minimize:';
      updateSep();
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
        behavior: HitTestBehavior.translucent,
        onPanStart: (_) => widget.onHeaderDrag?.call(),
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              border: Border(
                top: BorderSide(color: Theme.of(context).backgroundColor),
                bottom: BorderSide(color: context.borderColor),
              ),
            ),
            height: widget.height,
            width: double.infinity,
            child: Stack(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onDoubleTap: widget.onDoubleTap,
                ),
                ValueListenableBuilder<List<String>>(
                  valueListenable: seperator,
                  builder: (context, sep, _) => DefaultTextStyle.merge(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ).merge(widget.textStyle),
                    child: NavigationToolbar(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (hasWindowControls && sep[0].split(',').isNotEmpty)
                            SizedBox(width: widget.titlebarSpace),
                          for (var i in sep[0].split(','))
                            if (windowButtons[i] != null) windowButtons[i]!,
                          ...widget.start.map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: e,
                            ),
                          ),
                          if (hasWindowControls && sep[1].split(',').isNotEmpty)
                            SizedBox(width: widget.titlebarSpace),
                          for (var i in sep[1].split(','))
                            if (windowButtons[i] != null) windowButtons[i]!,
                          const SizedBox(width: 15),
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
