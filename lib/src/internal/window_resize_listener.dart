import 'package:flutter/material.dart';

class WindowResizeListener extends StatefulWidget {
  final Function(Size size) onResize;
  final Widget child;

  const WindowResizeListener(
      {Key? key, required this.onResize, required this.child})
      : super(key: key);

  @override
  _WindowResizeListenerState createState() => _WindowResizeListenerState();
}

class _WindowResizeListenerState extends State<WindowResizeListener>
    with WidgetsBindingObserver {
  late Size _lastSize;

  @override
  void initState() {
    _lastSize = WidgetsBinding.instance!.window.physicalSize;
    WidgetsBinding.instance!.addObserver(this);

    widget.onResize(_lastSize);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    var winSize = WidgetsBinding.instance!.window.physicalSize;

    if (winSize != _lastSize) {
      widget.onResize(winSize);
      _lastSize = winSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
