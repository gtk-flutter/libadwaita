import 'package:flutter/material.dart';
import 'package:libadwaita/src/controllers/flap_controller.dart';
import 'package:libadwaita/src/widgets/widgets.dart';
import 'package:libadwaita_core/libadwaita_core.dart';

class AdwScaffold extends StatefulWidget {
  const AdwScaffold({
    Key? key,
    required this.body,
    this.flap,
    this.flapStyle,
    this.flapOptions,
    this.flapController,
    @Deprecated('headerbar is deprecated, use the properties separately')
        AdwHeaderBar? Function(Widget?)? headerbar,
    this.viewSwitcher,
    this.headerBarStyle,
    this.start,
    this.title,
    this.end,
    required this.actions,
    this.controls,
  }) : super(key: key);

  final Widget body;

  final AdwSidebar Function(bool isDrawer)? flap;

  final FlapController? flapController;

  final FlapStyle? flapStyle;
  final FlapOptions? flapOptions;

  final HeaderBarStyle? headerBarStyle;

  final List<Widget>? start;
  final Widget? title;
  final List<Widget>? end;

  final AdwActions actions;
  final AdwControls? controls;

  final Widget? viewSwitcher;

  @override
  _AdwScaffoldState createState() => _AdwScaffoldState();
}

class _AdwScaffoldState extends State<AdwScaffold> {
  FlapController? _flapController;

  @override
  void initState() {
    super.initState();
    _flapController = widget.flapController ?? FlapController();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;
    final isFlapVisible = widget.flap != null &&
        (widget.flapOptions == null || widget.flapOptions!.visible);

    final flap = isFlapVisible
        ? SizedBox(
            width: 200,
            child: Drawer(
              elevation: 25,
              child: widget.flap!(true),
            ),
          )
        : null;

    return SafeArea(
      child: Column(
        children: [
          AdwHeaderBar(
            actions: widget.actions,
            controls: widget.controls,
            title: widget.viewSwitcher ?? widget.title,
            end: widget.end ?? [],
            start: widget.start ?? [],
            style: widget.headerBarStyle ?? const HeaderBarStyle(),
          ),
          Expanded(
            child: Scaffold(
              drawerEnableOpenDragGesture: _flapController
                      ?.shouldEnableDrawerGesture(FlapPosition.start) ??
                  false,
              endDrawerEnableOpenDragGesture: _flapController
                      ?.shouldEnableDrawerGesture(FlapPosition.end) ??
                  false,
              onDrawerChanged: _flapController?.onDrawerChanged,
              drawer: flap,
              endDrawer: flap,
              body: isFlapVisible
                  ? AdwFlap(
                      flap: widget.flap!(false),
                      controller: widget.flapController,
                      style: widget.flapStyle,
                      options: widget.flapOptions,
                      child: widget.body,
                    )
                  : widget.body,
              bottomNavigationBar: widget.viewSwitcher != null && isMobile
                  ? SizedBox(
                      height: 51,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.viewSwitcher!,
                        ],
                      ),
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
