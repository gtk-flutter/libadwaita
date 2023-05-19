import 'package:flutter/material.dart';

class WindowResizeListener extends StatefulWidget {
  const WindowResizeListener({
    super.key,
    required this.onResize,
    required this.child,
  });

  final void Function(Size size) onResize;
  final Widget child;

  @override
  _WindowResizeListenerState createState() => _WindowResizeListenerState();
}

class _WindowResizeListenerState extends State<WindowResizeListener>
    with WidgetsBindingObserver {
  Size _lastSize = Size.zero;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onResize(View.of(context).physicalSize);
    });
    WidgetsBinding.instance.addObserver(this);

    widget.onResize(_lastSize);

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final winSize = View.of(context).physicalSize;

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
