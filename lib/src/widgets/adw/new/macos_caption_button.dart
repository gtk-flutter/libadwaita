import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class MacOSCaptionButton extends StatefulWidget {
  const MacOSCaptionButton({
    super.key,
    required this.type,
    required this.onPressed,
  });

  final WindowButtonType type;
  final VoidCallback? onPressed;

  @override
  State<MacOSCaptionButton> createState() => _MacOSCaptionButtonState();
}

class _MacOSCaptionButtonState extends State<MacOSCaptionButton> {
  bool _isHovering = false;
  bool _isPressed = false;

  void _onEntered({required bool hovered}) {
    setState(() => _isHovering = hovered);
  }

  void _onActive({required bool pressed}) {
    setState(() => _isPressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onExit: (value) => _onEntered(hovered: false),
      onHover: (value) => _onEntered(hovered: true),
      child: GestureDetector(
        onTapDown: (_) => _onActive(pressed: true),
        onTapCancel: () => _onActive(pressed: false),
        onTapUp: (_) => _onActive(pressed: false),
        behavior: HitTestBehavior.opaque,
        onTap: widget.onPressed,
        child: Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.symmetric(vertical: 4)
              .copyWith(left: 2, right: 6),
          decoration: BoxDecoration(
            border: Border.all(
              color: () {
                if (_isPressed) {
                  switch (widget.type) {
                    case WindowButtonType.close:
                      return const Color(0xffad3934);
                    case WindowButtonType.maximize:
                      return const Color(0xff128622);
                    case WindowButtonType.minimize:
                      return const Color(0xffad7d15);
                  }
                }

                switch (widget.type) {
                  case WindowButtonType.close:
                    return const Color(0xffe2463f);
                  case WindowButtonType.maximize:
                    return const Color(0xff12ac28);
                  case WindowButtonType.minimize:
                    return const Color(0xffe1a116);
                }
              }(),
            ),
            color: () {
              if (_isPressed) {
                switch (widget.type) {
                  case WindowButtonType.close:
                    return const Color(0xffbf4943);
                  case WindowButtonType.maximize:
                    return const Color(0xff1f9a31);
                  case WindowButtonType.minimize:
                    return const Color(0xffbf9123);
                }
              }
              switch (widget.type) {
                case WindowButtonType.close:
                  return const Color(0xffff5f57);
                case WindowButtonType.maximize:
                  return const Color(0xff28c940);
                case WindowButtonType.minimize:
                  return const Color(0xffffbd2e);
              }
            }(),
            borderRadius: BorderRadius.circular(100),
          ),
          child: _isHovering
              ? Center(
                  child: CustomPaint(
                    size: () {
                      switch (widget.type) {
                        case WindowButtonType.close:
                          return const Size(7, 7);
                        case WindowButtonType.minimize:
                          return const Size(7, 7 * .1375);
                        case WindowButtonType.maximize:
                          return const Size(7, 7);
                      }
                    }(),
                    painter: () {
                      switch (widget.type) {
                        case WindowButtonType.close:
                          return CloseButton();
                        case WindowButtonType.minimize:
                          return MinimizeButton();
                        case WindowButtonType.maximize:
                          return FullscreenActiveButton();
                      }
                    }(),
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}

/// WIDTH, (WIDTH*1).toDouble()
class FullscreenActiveButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path()
      ..moveTo(size.width, size.height * 0.5696203)
      ..lineTo(size.width, size.height * 0.4303797)
      ..lineTo(size.width * 0.5696203, size.height * 0.4303797)
      ..lineTo(size.width * 0.5696203, 0)
      ..lineTo(size.width * 0.4303797, 0)
      ..lineTo(size.width * 0.4303797, size.height * 0.4303797)
      ..lineTo(0, size.height * 0.4303797)
      ..lineTo(0, size.height * 0.5696203)
      ..lineTo(size.width * 0.4303797, size.height * 0.5696203)
      ..lineTo(size.width * 0.4303797, size.height)
      ..lineTo(size.width * 0.5696203, size.height)
      ..lineTo(size.width * 0.5696203, size.height * 0.5696203)
      ..close();

    final paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff006400).withOpacity(1);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// WIDTH, (WIDTH*0.9833333333333334).toDouble()
class FullScreenInactiveButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path()
      ..moveTo(size.width * 0.9000000, 0)
      ..lineTo(size.width * 0.2333333, 0)
      ..lineTo(size.width, size.height * 0.7627119)
      ..lineTo(size.width, size.height * 0.1016949)
      ..cubicTo(
        size.width * 0.9500000,
        size.height * 0.1016949,
        size.width * 0.8833333,
        size.height * 0.05084746,
        size.width * 0.9000000,
        0,
      )
      ..close();

    final paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff006400).withOpacity(1);
    canvas.drawPath(path_0, paint0Fill);

    final path_1 = Path()
      ..moveTo(size.width * 0.1000000, size.height)
      ..lineTo(size.width * 0.7666667, size.height)
      ..lineTo(0, size.height * 0.2372881)
      ..lineTo(0, size.height * 0.8983051)
      ..cubicTo(
        size.width * 0.05000000,
        size.height * 0.8983051,
        size.width * 0.1000000,
        size.height * 0.9491525,
        size.width * 0.1000000,
        size.height,
      )
      ..close();

    final paint1Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff006400).withOpacity(1);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// WIDTH, (WIDTH*0.1375).toDouble()
class MinimizeButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff995700).withOpacity(1);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// WIDTH, (WIDTH*1).toDouble()
class CloseButton extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path_0 = Path()
      ..moveTo(size.width, size.height * 0.1250000)
      ..lineTo(size.width * 0.8750000, 0)
      ..lineTo(size.width * 0.5000000, size.height * 0.3750000)
      ..lineTo(size.width * 0.1250000, 0)
      ..lineTo(0, size.height * 0.1250000)
      ..lineTo(size.width * 0.3750000, size.height * 0.5000000)
      ..lineTo(0, size.height * 0.8750000)
      ..lineTo(size.width * 0.1250000, size.height)
      ..lineTo(size.width * 0.5000000, size.height * 0.6250000)
      ..lineTo(size.width * 0.8750000, size.height)
      ..lineTo(size.width, size.height * 0.8750000)
      ..lineTo(size.width * 0.6250000, size.height * 0.5000000)
      ..close();

    final paint0Fill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xff4d0000).withOpacity(1);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
