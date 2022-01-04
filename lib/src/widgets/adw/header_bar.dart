import 'dart:io';

import 'package:dbus/dbus.dart';
import 'package:flutter/material.dart';
import 'package:gsettings/gsettings.dart';
import 'package:libadwaita/libadwaita.dart';

class AdwHeaderBar extends StatefulWidget {
  /// The leading widget for the headerbar
  final Widget start;

  /// The center widget for the headerbar
  final Widget title;

  /// The trailing widget for the headerbar
  final Widget end;

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

  /// To be used with window_decorations package
  /// If you don't want that. use AdwHeaderBar.minimal*
  AdwHeaderBar({
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
    this.start = const SizedBox(),
    this.title = const SizedBox(),
    this.end = const SizedBox(),
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

  const AdwHeaderBar.minimal({
    Key? key,
    this.onDoubleTap,
    this.onHeaderDrag,
    this.start = const SizedBox(),
    this.title = const SizedBox(),
    this.end = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    this.minimizeBtn,
    this.maximizeBtn,
    this.closeBtn,
  }) : super(key: key);

  AdwHeaderBar.bitsdojo({
    Key? key,
    required Widget Function(
      String name,
      dynamic type,
      void Function()? onPressed,
    )
        windowDecor,
    dynamic themeType,

    /// The appWindow object from bitsdojo_window package
    required appWindow,
    this.start = const SizedBox(),
    this.title = const SizedBox(),
    this.end = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    bool showMinimize = true,
    bool showMaximize = true,
    bool showClose = true,
  })  : closeBtn = windowDecor(
          'close',
          themeType,
          showClose ? appWindow?.close : null,
        ),
        maximizeBtn = windowDecor(
          'maximize',
          themeType,
          showMaximize ? appWindow?.maximize : null,
        ),
        minimizeBtn = windowDecor(
          'minimize',
          themeType,
          showMinimize ? appWindow?.minimize : null,
        ),
        onHeaderDrag = appWindow?.startDragging,
        onDoubleTap = appWindow?.maximizeOrRestore,
        super(key: key);

  AdwHeaderBar.minimalBitsdojo({
    Key? key,

    /// The appWindow object from bitsdojo_window package
    required appWindow,
    this.start = const SizedBox(),
    this.title = const SizedBox(),
    this.end = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    Widget Function(VoidCallback onTap)? minimizeBtn,
    Widget Function(VoidCallback onTap)? maximizeBtn,
    Widget Function(VoidCallback onTap)? closeBtn,
  })  : onHeaderDrag = appWindow?.startDragging,
        onDoubleTap = appWindow?.maximizeOrRestore,
        minimizeBtn = minimizeBtn?.call(appWindow?.minimize),
        maximizeBtn = maximizeBtn?.call(appWindow?.maximizeOrRestore),
        closeBtn = closeBtn?.call(appWindow?.close),
        super(key: key);

  AdwHeaderBar.nativeshell({
    Key? key,
    required Widget Function(
      String name,
      dynamic type,
      void Function()? onPressed,
    )
        windowDecor,
    dynamic themeType,

    /// The Window.of(context) object from nativeshell package
    required window,
    this.start = const SizedBox(),
    this.title = const SizedBox(),
    this.end = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    bool showMinimize = true,
    bool showMaximize = true,
    bool showClose = true,
  })  : onHeaderDrag = window?.performDrag,
        onDoubleTap = null,
        minimizeBtn = null,
        maximizeBtn = null,
        closeBtn = windowDecor(
          'close',
          themeType,
          showClose ? window.close : null,
        ),
        super(key: key);

  AdwHeaderBar.minimalNativeshell({
    Key? key,

    /// The Window.of(context) object from nativeshell package
    required window,
    this.start = const SizedBox(),
    this.title = const SizedBox(),
    this.end = const SizedBox(),
    this.padding = const EdgeInsets.only(left: 3, right: 5),
    this.titlebarSpace = 4,
    this.height = 51,
    Widget Function(VoidCallback onTap)? minimizeBtn,
    Widget Function(VoidCallback onTap)? maximizeBtn,
    Widget Function(VoidCallback onTap)? closeBtn,
  })  : onHeaderDrag = window?.performDrag,
        onDoubleTap = null,
        minimizeBtn = null,
        maximizeBtn = null,
        closeBtn = closeBtn?.call(window.close),
        super(key: key);

  @override
  State<AdwHeaderBar> createState() => _AdwHeaderBarState();
}

class _AdwHeaderBarState extends State<AdwHeaderBar> {
  bool get hasWindowControls =>
      widget.closeBtn != null ||
      widget.minimizeBtn != null ||
      widget.maximizeBtn != null;

  late ValueNotifier<List<String>> seperator =
      ValueNotifier(["", "minimize,maximize,close"]);

  @override
  void initState() {
    super.initState();

    late ValueNotifier<String> order =
        ValueNotifier(":minimize,maximize,close");
    updateSep() {
      if (mounted) {
        seperator.value = order.value.split(':');
      }
    }

    if (Platform.isLinux) {
      ValueNotifier<DBusString?> buttonLayout = ValueNotifier(null);
      var schema = GSettings('org.gnome.desktop.wm.preferences');
      WidgetsBinding.instance?.addPostFrameCallback((_) async {
        buttonLayout.value = await schema.get('button-layout') as DBusString;
        if (buttonLayout.value != null) {
          order.value = buttonLayout.value!.value;
        }
        updateSep();
      });
    } else if (Platform.isMacOS) {
      order.value = "close,maximize,minimize:";
      updateSep();
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget?> windowButtons = {
      "maximize": widget.maximizeBtn,
      "minimize": widget.minimizeBtn,
      "close": widget.closeBtn,
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
                  bottom: BorderSide(color: context.borderColor)),
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
                    builder: (context, sep, _) => NavigationToolbar(
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (hasWindowControls &&
                                  sep[0].split(',').isNotEmpty)
                                SizedBox(width: widget.titlebarSpace),
                              for (var i in sep[0].split(','))
                                if (windowButtons[i] != null) windowButtons[i]!,
                              widget.start,
                            ],
                          ),
                          middle: widget.title,
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              widget.end,
                              if (hasWindowControls &&
                                  sep[1].split(',').isNotEmpty)
                                SizedBox(width: widget.titlebarSpace),
                              for (var i in sep[1].split(','))
                                if (windowButtons[i] != null) windowButtons[i]!,
                            ],
                          ),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
