import 'package:flutter/material.dart';

/// Set of status that a [AdwButton] widget can be at any given time.
enum AdwButtonStatus { enabled, active, enabledHovered, activeHovered, tapDown }

typedef AdwButtonColorBuilder = Color? Function(BuildContext, AdwButtonStatus);

typedef AdwButtonWidgetBuilder = Widget Function(
  BuildContext,
  AdwButtonStatus,
  Widget?,
);

/// [AdwButton] is a widget used as a base to build Adwaita-style widgets
/// with pressed and hover properties.
///
/// Widgets that use [AdwButton] as their base can rebuild
/// their background through the [backgroundColorBuilder] callback.
class AdwButton extends StatefulWidget {
  const AdwButton({
    Key? key,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.onPressed,
    this.backgroundColorBuilder = defaultBackgroundColorBuilder,
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
  })  : assert(builder != null || child != null),
        super(key: key);

  const AdwButton.circular({
    Key? key,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.onPressed,
    this.backgroundColorBuilder = defaultBackgroundColorBuilder,
    this.border,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.ease,
    this.isActive = false,
  })  : assert(builder != null || child != null),
        constraints = const BoxConstraints.tightFor(width: 34, height: 34),
        shape = BoxShape.circle,
        borderRadius = null,
        super(key: key);

  const AdwButton.pill({
    Key? key,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.onPressed,
    this.backgroundColorBuilder = defaultBackgroundColorBuilder,
    this.constraints,
    this.border,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.ease,
    this.isActive = false,
  })  : borderRadius = const BorderRadius.all(
          Radius.circular(9999.0),
        ),
        shape = BoxShape.rectangle,
        assert(builder != null || child != null),
        super(key: key);

  const AdwButton.flat({
    Key? key,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.onPressed,
    this.backgroundColorBuilder = flatBackgroundColorBuilder,
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
  })  : assert(builder != null || child != null),
        super(key: key);

  const AdwButton.outline({
    Key? key,
    this.padding = const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.onPressed,
    this.backgroundColorBuilder = flatBackgroundColorBuilder,
    this.constraints,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(8.0),
    ),
    this.border = const Border.fromBorderSide(
      BorderSide(color: Colors.grey),
    ),
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.ease,
    this.isActive = false,
  })  : assert(builder != null || child != null),
        super(key: key);

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  final EdgeInsetsGeometry padding;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry margin;

  /// Builder function used to create the child widget inside
  /// the button widget.
  ///
  /// You can get the [child] parameter using this build method.
  final AdwButtonWidgetBuilder? builder;

  /// Widget that will be rendered inside this button.
  final Widget? child;

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
  final BorderRadius? borderRadius;

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

  static Color? defaultBackgroundColorBuilder(
    BuildContext context,
    AdwButtonStatus status,
  ) {
    if (Theme.of(context).brightness == Brightness.light) {
      return Colors.black.resolveDefaultAdwButtonColor(context, status);
    } else {
      return Colors.white.resolveDefaultAdwButtonColor(context, status);
    }
  }

  static Color? flatBackgroundColorBuilder(
    BuildContext context,
    AdwButtonStatus status,
  ) {
    if (Theme.of(context).brightness == Brightness.light) {
      return Colors.black.resolveFlatAdwButtonColor(context, status);
    } else {
      return Colors.white.resolveFlatAdwButtonColor(context, status);
    }
  }

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
    return Padding(
      padding: widget.margin,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(
          () => _status = widget.isActive
              ? AdwButtonStatus.activeHovered
              : AdwButtonStatus.enabledHovered,
        ),
        onExit: (_) => setState(
          () => _status = widget.isActive
              ? AdwButtonStatus.active
              : AdwButtonStatus.enabled,
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
            child: widget.child ??
                widget.builder!(
                  context,
                  _status,
                  widget.child,
                ),
          ),
        ),
      ),
    );
  }
}

extension AdwButtonBackgroundColor on Color {
  Color? resolveDefaultAdwButtonColor(
    BuildContext context,
    AdwButtonStatus status,
  ) {
    if (Theme.of(context).brightness == Brightness.light) {
      switch (status) {
        case AdwButtonStatus.enabled:
          return withOpacity(0.08);
        case AdwButtonStatus.enabledHovered:
          return withOpacity(0.12);
        case AdwButtonStatus.active:
          return withOpacity(0.16);
        case AdwButtonStatus.activeHovered:
          return withOpacity(0.20);
        case AdwButtonStatus.tapDown:
          return withOpacity(0.20);
        default:
          return null;
      }
    } else {
      switch (status) {
        case AdwButtonStatus.enabled:
          return withOpacity(0.10);
        case AdwButtonStatus.enabledHovered:
          return withOpacity(0.15);
        case AdwButtonStatus.active:
          return withOpacity(0.20);
        case AdwButtonStatus.activeHovered:
          return withOpacity(0.245);
        case AdwButtonStatus.tapDown:
          return withOpacity(0.25);
        default:
          return null;
      }
    }
  }

  Color? resolveFlatAdwButtonColor(
    BuildContext context,
    AdwButtonStatus status,
  ) {
    if (Theme.of(context).brightness == Brightness.light) {
      switch (status) {
        case AdwButtonStatus.enabledHovered:
          return withOpacity(0.055);
        case AdwButtonStatus.active:
          return withOpacity(0.08);
        case AdwButtonStatus.activeHovered:
          return withOpacity(0.105);
        case AdwButtonStatus.tapDown:
          return withOpacity(0.13);
        default:
          return null;
      }
    } else {
      switch (status) {
        case AdwButtonStatus.enabledHovered:
          return withOpacity(0.07);
        case AdwButtonStatus.active:
          return withOpacity(0.10);
        case AdwButtonStatus.activeHovered:
          return withOpacity(0.13);
        case AdwButtonStatus.tapDown:
          return withOpacity(0.19);
        default:
          return null;
      }
    }
  }
}
