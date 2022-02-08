import 'package:flutter/material.dart';
import 'package:libadwaita/src/controllers/flap_controller.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

class AdwScaffold extends StatefulWidget {
  const AdwScaffold({
    Key? key,
    required this.body,
    this.flap,
    this.flapStyle,
    this.flapController,
    this.headerbar,
    this.viewSwitcher,
  }) : super(key: key);

  final Widget body;

  final AdwSidebar Function(bool isDrawer)? flap;

  final FlapController? flapController;

  final FlapStyle? flapStyle;

  final Widget? Function(Widget? viewSwitcher)? headerbar;

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
    final headerbar =
        widget.headerbar?.call(!isMobile ? widget.viewSwitcher : null);
    final flap = widget.flap != null
        ? SizedBox(
            width: 200,
            child: Drawer(elevation: 25, child: widget.flap!(true)),
          )
        : null;
    return Column(
      children: [
        if (headerbar != null) headerbar,
        Expanded(
          child: Scaffold(
            drawerEnableOpenDragGesture: _flapController
                    ?.shouldEnableDrawerGesture(FlapPosition.start) ??
                false,
            endDrawerEnableOpenDragGesture:
                _flapController?.shouldEnableDrawerGesture(FlapPosition.end) ??
                    false,
            onDrawerChanged: _flapController?.onDrawerChanged,
            drawer: flap,
            endDrawer: flap,
            body: widget.flap != null
                ? AdwFlap(
                    flap: widget.flap!(false),
                    controller: widget.flapController,
                    style: widget.flapStyle,
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
    );
  }
}
