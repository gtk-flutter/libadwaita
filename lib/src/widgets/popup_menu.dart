import 'package:libadwaita/libadwaita.dart';
import 'package:flutter/material.dart';

class CustomTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipPath(
              clipper: CustomTriangleClipper(),
              child: Container(
                width: 26,
                height: 16,
                color: backgroundColor,
              ),
            ),
            SizedBox(
              width: width,
              height: height,
              child: Material(
                type: MaterialType.card,
                borderRadius: BorderRadius.circular(8),
                color: backgroundColor,
                child: body,
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

class AdwPopupMenu extends StatefulWidget {
  /// The body of the popup
  final Widget body;

  // The icon for Popup menu, use size of 17 for better results
  final Widget icon;

  /// The width of the popup
  final double popupWidth;

  /// The height of the popup
  final double? popupHeight;

  const AdwPopupMenu({
    Key? key,
    required this.body,
    this.icon = const Icon(Icons.menu, size: 17),
    this.popupWidth = 200,
    this.popupHeight,
  }) : super(key: key);

  @override
  State<AdwPopupMenu> createState() => _AdwPopupMenuState();
}

class _AdwPopupMenuState extends State<AdwPopupMenu> {
  late GlobalKey _key;

  @override
  void initState() {
    super.initState();
    _key = GlobalKey();
  }

  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return AdwHeaderButton(
      icon: Center(key: _key, child: widget.icon),
      isActive: isActive,
      onPressed: () {
        setState(() => isActive = true);
        showPopover(
          context: context,
          child: widget.body,
          width: widget.popupWidth,
          height: widget.popupHeight,
          backgroundColor: Theme.of(context).cardColor,
          contentOffset: const Offset(0, 4),
        ).whenComplete(() => setState(() => isActive = false));
        /* showPopover( */
        /*   context: context, */
        /*   barrierColor: Colors.transparent, */
        /*   contentDyOffset: 4, */
        /*   backgroundColor: Theme.of(context).cardColor, */
        /*   transitionDuration: const Duration(milliseconds: 150), */
        /*   bodyBuilder: (context) => SizedBox(child: widget.body), */
        /*   direction: PopoverDirection.top, */
        /*   width: widget.popupWidth, */
        /*   height: widget.popupHeight, */
        /*   arrowHeight: 10, */
        /*   arrowWidth: 22, */
        /* ).whenComplete(() => setState(() => isActive = false)); */
      },
    );
  }
}
