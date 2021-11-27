import 'package:flutter/material.dart';
import 'package:libadwaita/src/controllers/flap_controller.dart';
import 'package:libadwaita/src/widgets/widgets.dart';

class AdwScaffold extends StatefulWidget {
  final Widget body;
  final FlapController? flapController;
  final Widget? drawer;

  const AdwScaffold({
    Key? key,
    required this.body,
    this.flapController,
    this.drawer,
  }) : super(key: key);

  @override
  _AdwScaffoldState createState() => _AdwScaffoldState();
}

class _AdwScaffoldState extends State<AdwScaffold> {
  FlapController? _flapController;

  @override
  void initState() {
    super.initState();
    if (widget.body is AdwFlap) {
      _flapController = widget.flapController ?? FlapController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: ((_flapController?.isModal ?? false) &&
          _flapController?.position == FlapPosition.start),
      endDrawerEnableOpenDragGesture: ((_flapController?.isModal ?? false) &&
          _flapController?.position == FlapPosition.end),
      onDrawerChanged: _flapController?.onDrawerChanged,
      drawer: widget.drawer,
      endDrawer: widget.drawer,
      body: widget.body,
    );
  }
}
