import 'dart:math';

import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class WindowCaptionButtonIcon extends StatelessWidget {
  const WindowCaptionButtonIcon({
    super.key,
    required this.type,
    required this.color,
  });

  final WindowButtonType type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case WindowButtonType.close:
        return CloseIcon(color: color);
      case WindowButtonType.maximize:
        return MaximizeIcon(color: color);
      case WindowButtonType.minimize:
        return MinimizeIcon(color: color);
    }
  }
}

// ignore: must_be_immutable
class WindowCaptionButton extends StatefulWidget {
  WindowCaptionButton({
    super.key,
    this.brightness,
    required this.type,
    required this.onPressed,
  }) {
    if (type == WindowButtonType.close) {
      _lightButtonBgColorScheme = _ButtonBgColorScheme(
        normal: Colors.transparent,
        hovered: const Color(0xffC42B1C),
        pressed: const Color(0xffC42B1C).withOpacity(0.9),
      );
      _lightButtonIconColorScheme = _ButtonIconColorScheme(
        normal: Colors.black.withOpacity(0.8956),
        hovered: Colors.white,
        pressed: Colors.white.withOpacity(0.7),
        disabled: Colors.black.withOpacity(0.3614),
      );
      _darkButtonBgColorScheme = _ButtonBgColorScheme(
        normal: Colors.transparent,
        hovered: const Color(0xffC42B1C),
        pressed: const Color(0xffC42B1C).withOpacity(0.9),
      );
      _darkButtonIconColorScheme = _ButtonIconColorScheme(
        normal: Colors.white,
        hovered: Colors.white,
        pressed: Colors.white.withOpacity(0.786),
        disabled: Colors.black.withOpacity(0.3628),
      );
    }
  }

  final Brightness? brightness;
  final VoidCallback? onPressed;
  final WindowButtonType type;

  _ButtonBgColorScheme _lightButtonBgColorScheme = _ButtonBgColorScheme(
    normal: Colors.transparent,
    hovered: Colors.black.withOpacity(0.0373),
    pressed: Colors.black.withOpacity(0.0241),
  );
  _ButtonIconColorScheme _lightButtonIconColorScheme = _ButtonIconColorScheme(
    normal: Colors.black.withOpacity(0.8956),
    hovered: Colors.black.withOpacity(0.8956),
    pressed: Colors.black.withOpacity(0.6063),
    disabled: Colors.black.withOpacity(0.3614),
  );
  _ButtonBgColorScheme _darkButtonBgColorScheme = _ButtonBgColorScheme(
    normal: Colors.transparent,
    hovered: Colors.white.withOpacity(0.0605),
    pressed: Colors.white.withOpacity(0.0419),
  );
  _ButtonIconColorScheme _darkButtonIconColorScheme = _ButtonIconColorScheme(
    normal: Colors.white,
    hovered: Colors.white,
    pressed: Colors.white.withOpacity(0.786),
    disabled: Colors.black.withOpacity(0.3628),
  );

  _ButtonBgColorScheme get buttonBgColorScheme => brightness != Brightness.dark
      ? _lightButtonBgColorScheme
      : _darkButtonBgColorScheme;

  _ButtonIconColorScheme get buttonIconColorScheme =>
      brightness != Brightness.dark
          ? _lightButtonIconColorScheme
          : _darkButtonIconColorScheme;

  @override
  State<WindowCaptionButton> createState() => _WindowCaptionButtonState();
}

class _WindowCaptionButtonState extends State<WindowCaptionButton> {
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
    var bgColor = widget.buttonBgColorScheme.normal;
    var iconColor = widget.buttonIconColorScheme.normal;

    if (_isHovering) {
      bgColor = widget.buttonBgColorScheme.hovered;
      iconColor = widget.buttonIconColorScheme.hovered;
    }
    if (_isPressed) {
      bgColor = widget.buttonBgColorScheme.pressed;
      iconColor = widget.buttonIconColorScheme.pressed;
    }

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
          constraints: const BoxConstraints(minWidth: 58, minHeight: 32),
          decoration: BoxDecoration(
            color: bgColor,
          ),
          child: Center(
            child: SizedBox(
              width: 15,
              child: WindowCaptionButtonIcon(
                type: widget.type,
                color: iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ButtonBgColorScheme {
  _ButtonBgColorScheme({
    required this.normal,
    required this.hovered,
    required this.pressed,
  });
  final Color normal;
  final Color hovered;
  final Color pressed;
}

class _ButtonIconColorScheme {
  _ButtonIconColorScheme({
    required this.normal,
    required this.hovered,
    required this.pressed,
    required this.disabled,
  });
  final Color normal;
  final Color hovered;
  final Color pressed;
  final Color disabled;
}

// Switched to CustomPaint icons by https://github.com/esDotDev

/// Close
class CloseIcon extends StatelessWidget {
  const CloseIcon({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.topLeft,
        child: Stack(
          children: [
            // Use rotated containers instead of a painter because it renders
            // slightly crisper than a painter for some reason.
            Transform.rotate(
              angle: pi * .25,
              child:
                  Center(child: Container(width: 14, height: 1, color: color)),
            ),
            Transform.rotate(
              angle: pi * -.25,
              child:
                  Center(child: Container(width: 14, height: 1, color: color)),
            ),
          ],
        ),
      );
}

/// Maximize
class MaximizeIcon extends StatelessWidget {
  const MaximizeIcon({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => _AlignedPaint(_MaximizePainter(color));
}

class _MaximizePainter extends _IconPainter {
  _MaximizePainter(super.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = getPaint(color);
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width - 1, size.height - 1), p);
  }
}

/// Restore
class RestoreIcon extends StatelessWidget {
  const RestoreIcon({
    super.key,
    required this.color,
  });
  final Color color;
  @override
  Widget build(BuildContext context) => _AlignedPaint(_RestorePainter(color));
}

class _RestorePainter extends _IconPainter {
  _RestorePainter(super.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = getPaint(color);
    canvas
      ..drawRect(Rect.fromLTRB(0, 2, size.width - 2, size.height), p)
      ..drawLine(const Offset(2, 2), const Offset(2, 0), p)
      ..drawLine(const Offset(2, 0), Offset(size.width, 0), p)
      ..drawLine(
        Offset(size.width, 0),
        Offset(size.width, size.height - 2),
        p,
      )
      ..drawLine(
        Offset(size.width, size.height - 2),
        Offset(size.width - 2, size.height - 2),
        p,
      );
  }
}

/// Minimize
class MinimizeIcon extends StatelessWidget {
  const MinimizeIcon({super.key, required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => _AlignedPaint(_MinimizePainter(color));
}

class _MinimizePainter extends _IconPainter {
  _MinimizePainter(super.color);
  @override
  void paint(Canvas canvas, Size size) {
    final p = getPaint(color);
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      p,
    );
  }
}

/// Helpers
abstract class _IconPainter extends CustomPainter {
  _IconPainter(this.color);
  final Color color;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _AlignedPaint extends StatelessWidget {
  const _AlignedPaint(this.painter);
  final CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: CustomPaint(size: const Size(10, 10), painter: painter),
    );
  }
}

Paint getPaint(Color color, {bool isAntiAlias = false}) => Paint()
  ..color = color
  ..style = PaintingStyle.stroke
  ..isAntiAlias = isAntiAlias
  ..strokeWidth = 1;
