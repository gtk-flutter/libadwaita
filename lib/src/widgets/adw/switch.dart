// Copyright 2014 The Flutter Authors => BSD-3 License
// Copyright 2022 Gtk-Flutter Authors => LGPL-3 License

import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:libadwaita/src/utils/colors.dart';

// Examples can assume:
// bool _lights = false;
// void setState(VoidCallback fn) { }

/// A gtk-style switch.
///
/// Used to toggle the on/off state of a single setting.
///
/// The switch itself does not maintain any state. Instead, when the state of
/// the switch changes, the widget calls the [onChanged] callback. Most widgets
/// that use a switch will listen for the [onChanged] callback and rebuild the
/// switch with a new [value] to update the visual appearance of the switch.
///
/// {@tool snippet}
///
/// This sample shows how to use a [AdwSwitch] in a [ListTile]. The
/// [MergeSemantics] is used to turn the entire [ListTile] into a single item
/// for accessibility tools.
///
/// ```dart
/// MergeSemantics(
///   child: ListTile(
///     title: const Text('Lights'),
///     trailing: AdwSwitch(
///       value: _lights,
///       onChanged: (bool value) { setState(() { _lights = value; }); },
///     ),
///     onTap: () { setState(() { _lights = !_lights; }); },
///   ),
/// )
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [Switch], the material design equivalent.
///  * <https://developer.apple.com/ios/human-interface-guidelines/controls/switches/>
class AdwSwitch extends StatefulWidget {
  /// Creates a gtk-style switch.
  ///
  /// The [value] parameter must not be null.
  /// The [dragStartBehavior] parameter defaults to [DragStartBehavior.start]
  /// and must not be null.
  const AdwSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.activeColor,
    this.trackColor,
    this.thumbColor,
    this.dragStartBehavior = DragStartBehavior.start,
  });

  /// Whether this switch is on or off.
  ///
  /// Must not be null.
  final bool value;

  /// Called when the user toggles with switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled, which has a reduced
  /// opacity.
  ///
  /// The callback provided to onChanged should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// AdwSwitch(
  ///   value: _giveVerse,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _giveVerse = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool>? onChanged;

  /// The color to use when this switch is on.
  final Color? activeColor;

  /// The color to use for the background when the switch is off.
  final Color? trackColor;

  /// The color to use for the thumb of the switch.
  final Color? thumbColor;

  /// {@template flutter.Adw.AdwSwitch.dragStartBehavior}
  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag behavior used to move the
  /// switch from on to off will begin at the position where the drag gesture
  /// won the arena. If set to [DragStartBehavior.down] it will begin at the
  /// position where a down event was first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for
  ///    the different behaviors.
  ///
  /// {@endtemplate}
  final DragStartBehavior dragStartBehavior;

  @override
  State<AdwSwitch> createState() => _AdwSwitchState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
        FlagProperty(
          'value',
          value: value,
          ifTrue: 'on',
          ifFalse: 'off',
          showName: true,
        ),
      )
      ..add(
        ObjectFlagProperty<ValueChanged<bool>>(
          'onChanged',
          onChanged,
          ifNull: 'disabled',
        ),
      );
  }
}

class _AdwSwitchState extends State<AdwSwitch> with TickerProviderStateMixin {
  late TapGestureRecognizer _tap;
  late HorizontalDragGestureRecognizer _drag;

  late AnimationController _positionController;
  late CurvedAnimation position;

  late AnimationController _reactionController;
  late Animation<double> _reaction;

  bool get isInteractive => widget.onChanged != null;

  // A non-null boolean value that changes to true at the end of a drag if the
  // switch must be animated to the position indicated by the widget's value.
  bool needsPositionAnimation = false;

  @override
  void initState() {
    super.initState();

    _tap = TapGestureRecognizer()
      ..onTapDown = _handleTapDown
      ..onTapUp = _handleTapUp
      ..onTap = _handleTap
      ..onTapCancel = _handleTapCancel;
    _drag = HorizontalDragGestureRecognizer()
      ..onStart = _handleDragStart
      ..onUpdate = _handleDragUpdate
      ..onEnd = _handleDragEnd
      ..dragStartBehavior = widget.dragStartBehavior;

    _positionController = AnimationController(
      duration: _kToggleDuration,
      value: widget.value ? 1.0 : 0.0,
      vsync: this,
    );
    position = CurvedAnimation(
      parent: _positionController,
      curve: Curves.linear,
    );
    _reactionController = AnimationController(
      duration: _kReactionDuration,
      vsync: this,
    );
    _reaction = CurvedAnimation(
      parent: _reactionController,
      curve: Curves.ease,
    );
  }

  @override
  void didUpdateWidget(AdwSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    _drag.dragStartBehavior = widget.dragStartBehavior;

    if (needsPositionAnimation || oldWidget.value != widget.value) {
      _resumePositionAnimation(isLinear: needsPositionAnimation);
    }
  }

  // `isLinear` must be true if the position animation is trying to move the
  // thumb to the closest end after the most recent drag animation, so the curve
  // does not change when the controller's value is not 0 or 1.
  //
  // It can be set to false when it's an implicit animation triggered by
  // widget.value changes.
  void _resumePositionAnimation({bool isLinear = true}) {
    needsPositionAnimation = false;
    position
      ..curve = isLinear ? Curves.linear : Curves.ease
      ..reverseCurve = isLinear ? Curves.linear : Curves.ease.flipped;
    if (widget.value) {
      _positionController.forward();
    } else {
      _positionController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (isInteractive) needsPositionAnimation = false;
    _reactionController.forward();
  }

  void _handleTap() {
    if (isInteractive) {
      widget.onChanged!(!widget.value);
      _emitVibration();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.reverse();
    }
  }

  void _handleTapCancel() {
    if (isInteractive) _reactionController.reverse();
  }

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      needsPositionAnimation = false;
      _reactionController.forward();
      _emitVibration();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      position
        ..curve = Curves.linear
        ..reverseCurve = Curves.linear;
      final delta = details.primaryDelta! / _kTrackInnerLength;
      switch (Directionality.of(context)) {
        case TextDirection.rtl:
          _positionController.value -= delta;
          break;
        case TextDirection.ltr:
          _positionController.value += delta;
          break;
      }
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    // Deferring the animation to the next build phase.
    setState(() {
      needsPositionAnimation = true;
    });
    // Call onChanged when the user's intent to change value is clear.
    if (position.value >= 0.5 != widget.value) widget.onChanged!(!widget.value);
    _reactionController.reverse();
  }

  void _emitVibration() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        HapticFeedback.lightImpact();
        break;
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (needsPositionAnimation) _resumePositionAnimation();
    final switchTheme = Theme.of(context).switchTheme;

    return Opacity(
      opacity: widget.onChanged == null ? _kAdwSwitchDisabledOpacity : 1.0,
      child: _AdwSwitchRenderObjectWidget(
        value: widget.value,
        activeColor: widget.activeColor ??
            (switchTheme.thumbColor != null
                ? switchTheme.thumbColor!.resolve({MaterialState.selected}) ??
                    AdwDefaultColors.blue
                : AdwDefaultColors.blue),
        trackColor: widget.trackColor ??
            (switchTheme.trackColor != null
                ? switchTheme.trackColor!.resolve({MaterialState.focused}) ??
                    context.checkboxColor
                : context.checkboxColor),
        thumbColor: widget.thumbColor ??
            (switchTheme.thumbColor != null
                ? switchTheme.thumbColor!.resolve({MaterialState.focused}) ??
                    Colors.white
                : Colors.white),
        onChanged: widget.onChanged,
        textDirection: Directionality.of(context),
        state: this,
      ),
    );
  }

  @override
  void dispose() {
    _tap.dispose();
    _drag.dispose();

    _positionController.dispose();
    _reactionController.dispose();
    super.dispose();
  }
}

class _AdwSwitchRenderObjectWidget extends LeafRenderObjectWidget {
  const _AdwSwitchRenderObjectWidget({
    required this.value,
    required this.activeColor,
    required this.trackColor,
    required this.thumbColor,
    required this.onChanged,
    required this.textDirection,
    required this.state,
  });

  final bool value;
  final Color activeColor;
  final Color trackColor;
  final Color thumbColor;
  final ValueChanged<bool>? onChanged;
  final _AdwSwitchState state;
  final TextDirection textDirection;

  @override
  _RenderAdwSwitch createRenderObject(BuildContext context) {
    return _RenderAdwSwitch(
      value: value,
      activeColor: activeColor,
      trackColor: trackColor,
      thumbColor: thumbColor,
      onChanged: onChanged,
      textDirection: textDirection,
      state: state,
    );
  }

  @override
  void updateRenderObject(BuildContext context, _RenderAdwSwitch renderObject) {
    renderObject
      ..value = value
      ..activeColor = activeColor
      ..trackColor = trackColor
      ..thumbColor = thumbColor
      ..onChanged = onChanged
      ..textDirection = textDirection;
  }
}

const double _kTrackWidth = 50;
const double _kTrackHeight = 27;
const double _kTrackRadius = _kTrackHeight / 2.0;
const double _kTrackInnerStart = _kTrackHeight / 2.0;
const double _kTrackInnerEnd = _kTrackWidth - _kTrackInnerStart;
const double _kTrackInnerLength = _kTrackInnerEnd - _kTrackInnerStart;
const double _kSwitchWidth = 48;
const double _kSwitchHeight = 25;
// Opacity of a disabled switch, as eye-balled from iOS Simulator on Mac.
const double _kAdwSwitchDisabledOpacity = 0.5;

const Duration _kReactionDuration = Duration(milliseconds: 300);
const Duration _kToggleDuration = Duration(milliseconds: 200);

class _RenderAdwSwitch extends RenderConstrainedBox {
  _RenderAdwSwitch({
    required bool value,
    required Color activeColor,
    required Color trackColor,
    required Color thumbColor,
    ValueChanged<bool>? onChanged,
    required TextDirection textDirection,
    required _AdwSwitchState state,
  })  : _value = value,
        _activeColor = activeColor,
        _trackColor = trackColor,
        _thumbPainter = AdwThumbPainter.switchThumb(color: thumbColor),
        _onChanged = onChanged,
        _textDirection = textDirection,
        _state = state,
        super(
          additionalConstraints: const BoxConstraints.tightFor(
            width: _kSwitchWidth,
            height: _kSwitchHeight,
          ),
        ) {
    state.position.addListener(markNeedsPaint);
    state._reaction.addListener(markNeedsPaint);
  }

  final _AdwSwitchState _state;

  bool get value => _value;
  bool _value;
  set value(bool value) {
    if (value == _value) return;
    _value = value;
    markNeedsSemanticsUpdate();
  }

  Color get activeColor => _activeColor;
  Color _activeColor;
  set activeColor(Color value) {
    if (value == _activeColor) return;
    _activeColor = value;
    markNeedsPaint();
  }

  Color get trackColor => _trackColor;
  Color _trackColor;
  set trackColor(Color value) {
    if (value == _trackColor) return;
    _trackColor = value;
    markNeedsPaint();
  }

  Color get thumbColor => _thumbPainter.color;
  AdwThumbPainter _thumbPainter;
  set thumbColor(Color value) {
    if (value == thumbColor) return;
    _thumbPainter = AdwThumbPainter.switchThumb(color: value);
    markNeedsPaint();
  }

  ValueChanged<bool>? get onChanged => _onChanged;
  ValueChanged<bool>? _onChanged;
  set onChanged(ValueChanged<bool>? value) {
    if (value == _onChanged) return;
    final wasInteractive = isInteractive;
    _onChanged = value;
    if (wasInteractive != isInteractive) {
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  TextDirection get textDirection => _textDirection;
  TextDirection _textDirection;
  set textDirection(TextDirection value) {
    if (_textDirection == value) return;
    _textDirection = value;
    markNeedsPaint();
  }

  bool get isInteractive => onChanged != null;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    assert(debugHandleEvent(event, entry), 'Debug Handle Event failed!');
    if (event is PointerDownEvent && isInteractive) {
      _state._drag.addPointer(event);
      _state._tap.addPointer(event);
    }
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);

    if (isInteractive) config.onTap = _state._handleTap;

    config
      ..isEnabled = isInteractive
      ..isToggled = _value;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    final currentValue = _state.position.value;

    final double visualPosition;
    switch (textDirection) {
      case TextDirection.rtl:
        visualPosition = 1.0 - currentValue;
        break;
      case TextDirection.ltr:
        visualPosition = currentValue;
        break;
    }

    final paint = Paint()
      ..color = Color.lerp(trackColor, activeColor, currentValue)!;

    final trackRect = Rect.fromLTWH(
      offset.dx + (size.width - _kTrackWidth) / 2.0,
      offset.dy + (size.height - _kTrackHeight) / 2.0,
      _kTrackWidth,
      _kTrackHeight,
    );
    final trackRRect = RRect.fromRectAndRadius(
      trackRect,
      const Radius.circular(_kTrackRadius),
    );
    canvas.drawRRect(trackRRect, paint);

    final thumbLeft = lerpDouble(
      trackRect.left + _kTrackInnerStart - AdwThumbPainter.radius,
      trackRect.left + _kTrackInnerEnd - AdwThumbPainter.radius - 0,
      visualPosition,
    )!;
    final thumbRight = lerpDouble(
      trackRect.left + _kTrackInnerStart + AdwThumbPainter.radius,
      trackRect.left + _kTrackInnerEnd + AdwThumbPainter.radius,
      visualPosition,
    )!;
    final thumbCenterY = offset.dy + size.height / 2.0;
    final thumbBounds = Rect.fromLTRB(
      thumbLeft,
      thumbCenterY - AdwThumbPainter.radius,
      thumbRight,
      thumbCenterY + AdwThumbPainter.radius,
    );

    _clipRRectLayer.layer = context.pushClipRRect(
      needsCompositing,
      Offset.zero,
      thumbBounds,
      trackRRect,
      (PaintingContext innerContext, Offset offset) {
        _thumbPainter.paint(innerContext.canvas, thumbBounds);
      },
      oldLayer: _clipRRectLayer.layer,
    );
  }

  final LayerHandle<ClipRRectLayer> _clipRRectLayer =
      LayerHandle<ClipRRectLayer>();

  @override
  void dispose() {
    _clipRRectLayer.layer = null;
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder description) {
    super.debugFillProperties(description);
    description
      ..add(
        FlagProperty(
          'value',
          value: value,
          ifTrue: 'checked',
          ifFalse: 'unchecked',
          showName: true,
        ),
      )
      ..add(
        FlagProperty(
          'isInteractive',
          value: isInteractive,
          ifTrue: 'enabled',
          ifFalse: 'disabled',
          showName: true,
          defaultValue: true,
        ),
      );
  }
}

const Color _kThumbBorderColor = Color(0x0A000000);

const List<BoxShadow> _kSwitchBoxShadows = <BoxShadow>[
  BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 3),
    blurRadius: 8,
  ),
  BoxShadow(
    color: Color(0x0F000000),
    offset: Offset(0, 3),
    blurRadius: 1,
  ),
];

const List<BoxShadow> _kSliderBoxShadows = <BoxShadow>[
  BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 3),
    blurRadius: 8,
  ),
  BoxShadow(
    color: Color(0x29000000),
    offset: Offset(0, 1),
    blurRadius: 1,
  ),
  BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 3),
    blurRadius: 1,
  ),
];

/// Paints a gtk-style slider thumb or switch thumb.
///
/// Used by [AdwSwitch]
class AdwThumbPainter {
  /// Creates an object that paints a gtk-style slider thumb.
  const AdwThumbPainter({
    this.color = Colors.white,
    this.shadows = _kSliderBoxShadows,
  });

  /// Creates an object that paints a gtk-style switch thumb.
  const AdwThumbPainter.switchThumb({
    Color color = Colors.white,
    List<BoxShadow> shadows = _kSwitchBoxShadows,
  }) : this(color: color, shadows: shadows);

  /// The color of the interior of the thumb.
  final Color color;

  /// The list of [BoxShadow] to paint below the thumb.
  ///
  /// Must not be null.
  final List<BoxShadow> shadows;

  /// Half the default diameter of the thumb.
  static const double radius = 14;

  /// The default amount the thumb should be extended horizontally when pressed.
  static const double extension = 7;

  /// Paints the thumb onto the given canvas in the given rectangle.
  ///
  /// Consider using [radius] and [extension] when deciding how large a
  /// rectangle to use for the thumb.
  void paint(Canvas canvas, Rect rect) {
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(rect.shortestSide / 2.0),
    );

    for (final shadow in shadows) {
      canvas.drawRRect(rrect.shift(shadow.offset), shadow.toPaint());
    }

    canvas
      ..drawRRect(
        rrect.deflate(1.8),
        Paint()..color = _kThumbBorderColor,
      )
      ..drawRRect(rrect.deflate(2.3), Paint()..color = color);
  }
}
