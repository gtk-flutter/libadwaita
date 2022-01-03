import 'package:flutter/material.dart';

/// Set of status that a [AdwButton] widget can be at any given time.
enum AdwButtonStatus { enabled, active, enabledHovered, activeHovered, tapDown }

typedef AdwButtonColorBuilder = Color? Function(BuildContext, AdwButtonStatus);

typedef AdwButtonWidgetBuilder = Widget Function(BuildContext, AdwButtonStatus);

/// [AdwButton] is a widget used as a base to build Adwaita-style widgets
/// with pressed and hover properties.
///
/// Widgets that use [AdwButton] as their base can rebuild
/// their background through the [backgroundColorBuilder] callback.
class AdwButton extends StatefulWidget {
  const AdwButton({
    Key? key,
    this.padding = EdgeInsets.zero,
    required this.builder,
    this.onPressed,
    this.backgroundColorBuilder,
    this.constraints,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8.0),
    ),
    this.border,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.ease,
    this.isActive = false,
  }) : super(key: key);

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  final EdgeInsets padding;

  /// Builder function used to create the child widget inside
  /// the button widget.
  final AdwButtonWidgetBuilder builder;

  /// Action to perform when the widget is tapped.
  final VoidCallback? onPressed;

  /// Builder function used to create the background color of the button widget.
  final AdwButtonColorBuilder? backgroundColorBuilder;

  /// Additional constraints to apply to the child.
  ///
  /// The [padding] goes inside the constraints.
  final BoxConstraints? constraints;

  /// If non-null, the corners of this box are rounded by this [BorderRadius].
  ///
  /// Applies only to boxes with rectangular shapes; ignored if [shape] is not
  /// [BoxShape.rectangle].
  ///
  /// {@macro flutter.painting.BoxDecoration.clip}
  final BorderRadius borderRadius;

  /// A border to draw above the background [color].
  ///
  /// Follows the [shape] and [borderRadius].
  ///
  /// Use [Border] objects to describe borders that do not depend on the reading
  /// direction.
  ///
  /// Use [BoxBorder] objects to describe borders that should flip their left
  /// and right edges based on whether the text is being read left-to-right or
  /// right-to-left.
  ///
  final BoxBorder? border;

  /// The shape to fill the background [color] into and
  /// to cast as the [boxShadow].
  ///
  /// If this is [BoxShape.circle] then [borderRadius] is ignored.
  ///
  /// The [shape] cannot be interpolated; animating between two [BoxDecoration]s
  /// with different [shape]s will result in a discontinuity in the rendering.
  /// To interpolate between two shapes, consider using [ShapeDecoration] and
  /// different [ShapeBorder]s; in particular, [CircleBorder] instead of
  /// [BoxShape.circle] and [RoundedRectangleBorder] instead of
  /// [BoxShape.rectangle].
  ///
  /// {@macro flutter.painting.BoxDecoration.clip}
  final BoxShape shape;

  /// A list of shadows cast by this box behind the box.
  ///
  /// The shadow follows the [shape] of the box.
  final List<BoxShadow>? boxShadow;

  /// The duration over which to animate the parameters of this container.
  final Duration animationDuration;

  /// The curve to apply when animating the parameters of this container.
  final Curve animationCurve;

  /// Status flag to denote that the widget is active.
  /// Usually for popup buttons.
  final bool isActive;

  @override
  State<StatefulWidget> createState() => _AdwButtonState();
}

class _AdwButtonState extends State<AdwButton> {
  late AdwButtonStatus _status;

  @override
  void initState() {
    super.initState();
    _status =
        widget.isActive ? AdwButtonStatus.active : AdwButtonStatus.enabled;
  }

  @override
  void didUpdateWidget(covariant AdwButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_status == AdwButtonStatus.tapDown) {
      _status = widget.isActive
          ? AdwButtonStatus.activeHovered
          : AdwButtonStatus.enabledHovered;
    } else {
      _status =
          widget.isActive ? AdwButtonStatus.active : AdwButtonStatus.enabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(
        () => _status = widget.isActive
            ? AdwButtonStatus.activeHovered
            : AdwButtonStatus.enabledHovered,
      ),
      onExit: (_) => setState(
        () => _status =
            widget.isActive ? AdwButtonStatus.active : AdwButtonStatus.enabled,
      ),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown: (_) => setState(() => _status = AdwButtonStatus.tapDown),
        child: AnimatedContainer(
          padding: widget.padding,
          constraints: widget.constraints,
          duration: widget.animationDuration,
          curve: widget.animationCurve,
          decoration: BoxDecoration(
            border: widget.border,
            shape: widget.shape,
            boxShadow: widget.boxShadow,
            borderRadius: widget.borderRadius,
            color: widget.backgroundColorBuilder?.call(context, _status),
          ),
          child: widget.builder(context, _status),
        ),
      ),
    );
  }
}
