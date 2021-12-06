import 'package:flutter/material.dart';
import 'package:libadwaita/src/internal/triangle_painter.dart';
import 'package:libadwaita/src/utils/colors.dart';

class _PopoverRoute extends PopupRoute {
  final Widget body;
  final double width;
  final double? height;
  final Offset position;
  final Offset contentOffset;
  final Color backgroundColor;

  _PopoverRoute({
    required this.body,
    required this.width,
    required this.height,
    required this.position,
    required this.contentOffset,
    required this.backgroundColor,
  });

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => "Popover Scrim";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Align(
      alignment: Alignment.topLeft,
      child: Transform.translate(
        offset: Offset(
            position.dx + contentOffset.dx, position.dy + contentOffset.dy),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                CustomPaint(
                  painter: TriangleShadowPainter(color: backgroundColor),
                  size: const Size(36, 20),
                ),
                CustomPaint(
                  painter: TrianglePainter(color: backgroundColor),
                  size: const Size(34, 18),
                ),
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -5),
              child: SizedBox(
                width: width,
                height: height,
                child: Material(
                  elevation: 5,
                  // type: MaterialType.card,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.black26),
                  ),
                  color: backgroundColor,
                  child: body,
                  // shadowColor: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var y = (animation.value - 1) * 15;
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            child: child,
            offset: Offset(0, y),
          ),
        );
      },
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}

Future showPopover({
  required BuildContext context,
  required Widget child,
  required double width,
  required Color backgroundColor,
  required Offset contentOffset,
  required double? height,
}) {
  final NavigatorState navigator = Navigator.of(context, rootNavigator: true);

  final renderObject = context.findRenderObject();
  var translation = renderObject?.getTransformTo(null).getTranslation();
  Offset position = Offset(translation!.x, translation.y);

  final rbox = renderObject as RenderBox;
  final Size size = rbox.size;
  position += Offset(size.width / 2, size.height);
  position += Offset(-width / 2, 0);

  return navigator.push(
    _PopoverRoute(
      body: child,
      width: width,
      height: height,
      position: position,
      backgroundColor: backgroundColor,
      contentOffset: contentOffset,
    ),
  );
}
