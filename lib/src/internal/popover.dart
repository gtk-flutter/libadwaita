import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.black12;
    var half = size.width / 2;
    final path = Path();
    path.moveTo(1, 12);
    path.lineTo(half - 10, 12);
    path.lineTo(half, 1);
    path.lineTo(half + 10, 12);
    path.lineTo(size.width - 1, 12);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PopOverClipper extends CustomClipper<Path> {
  PopOverClipper();

  @override
  Path getClip(Size size) {
    var half = size.width / 2;
    final path = Path();
    path.moveTo(0, 15);
    path.lineTo(half - 10, 15);
    path.lineTo(half, 5);
    path.lineTo(half + 10, 15);
    path.lineTo(size.width, 15);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

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
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: width, maxHeight: height ?? 200),
              child: ClipPath(
                  clipper: PopOverClipper(),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: CustomPaint(
                          painter: BorderPainter(),
                          child: Container(
                              margin: const EdgeInsets.only(
                                  left: 0.0,
                                  top: 10.0,
                                  right: 0.0,
                                  bottom: 0.0),
                              child: body)))),
            )));
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
