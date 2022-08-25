import 'package:flutter/material.dart';
import 'package:libadwaita/src/utils/colors.dart';

/// Set of status that a [AdwButton] widget can be at any given time.
enum AdwButtonStatus { enabled, active, enabledHovered, activeHovered, tapDown }

typedef AdwButtonColorBuilder = Color? Function(
  BuildContext,
  Color? backgroundColor,
  AdwButtonStatus, {
  bool opaque,
});

typedef AdwButtonWidgetBuilder = Widget Function(
  BuildContext,
  AdwButtonStatus,
  Widget?,
);

const String _bothBuilderAndChildError = """
Either use builder or use child, Both can't be assigned at one""";

/// [AdwButton] is a widget used as a base to build Adwaita-style widgets
/// with pressed and hover properties.
///
/// Widgets that use [AdwButton] as their base can rebuild
/// their background through the [backgroundColorBuilder] callback.
class AdwButton extends StatefulWidget {
  const AdwButton({
    super.key,
    this.padding = defaultButtonPadding,
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.textStyle,
    this.onPressed,
    this.opaque = false,
    this.backgroundColor,
    this.backgroundColorBuilder = defaultBackgroundColorBuilder,
    this.constraints = defaultButtonConstrains,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(6),
    ),
    this.border,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOutQuad,
    this.isActive = false,
  }) : assert(
          builder != null || child != null,
          _bothBuilderAndChildError,
        );

  AdwButton.circular({
    super.key,
    double size = 34,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.textStyle,
    this.onPressed,
    this.opaque = false,
    this.backgroundColor,
    this.backgroundColorBuilder = defaultBackgroundColorBuilder,
    this.border,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOutQuad,
    this.isActive = false,
  })  : assert(builder != null || child != null, _bothBuilderAndChildError),
        constraints = BoxConstraints.tightFor(width: size, height: size),
        shape = BoxShape.circle,
        borderRadius = null;

  const AdwButton.pill({
    super.key,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.textStyle,
    this.onPressed,
    this.opaque = false,
    this.backgroundColor,
    this.backgroundColorBuilder = defaultBackgroundColorBuilder,
    this.constraints = defaultButtonConstrains,
    this.border,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOutQuad,
    this.isActive = false,
  })  : borderRadius = const BorderRadius.all(
          Radius.circular(9999),
        ),
        shape = BoxShape.rectangle,
        assert(builder != null || child != null, _bothBuilderAndChildError);

  const AdwButton.flat({
    super.key,
    this.padding = defaultButtonPadding,
    this.margin = EdgeInsets.zero,
    this.builder,
    this.child,
    this.textStyle,
    this.onPressed,
    this.backgroundColor,
    this.backgroundColorBuilder = flatBackgroundColorBuilder,
    this.constraints = defaultButtonConstrains,
    this.borderRadius = const BorderRadius.all(
      Radius.circular(6),
    ),
    this.border,
    this.shape = BoxShape.rectangle,
    this.boxShadow,
    this.animationDuration = const Duration(milliseconds: 200),
    this.animationCurve = Curves.easeOutQuad,
    this.isActive = false,
  })  : opaque = false,
        assert(builder != null || child != null, _bothBuilderAndChildError);

  static const defaultButtonConstrains = BoxConstraints(
    minHeight: 24,
    minWidth: 16,
  );

  static const defaultButtonPadding = EdgeInsets.symmetric(
    vertical: 7,
    horizontal: 17,
  );

  /// Empty space to inscribe inside the [BoxDecoration].
  ///  The [child], if any, is placed inside this padding.
  final EdgeInsetsGeometry padding;

  /// Empty space to surround the [BoxDecoration] and [child].
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

  /// Whether the [AdwButton] has some tranparaceny or
  /// is it fully opaque
  final bool opaque;

  /// The backgroundColor of the [AdwButton].
  /// This is then passed to [backgroundColorBuilder]
  /// to build this button for different [AdwButtonStatus]
  final Color? backgroundColor;

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

  /// A border to draw above the background color.
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

  /// Default text style applied to the child widget.
  final TextStyle? textStyle;

  /// The shape to fill the background color into and
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
    Color? backgroundColor,
    AdwButtonStatus status, {
    bool opaque = false,
  }) {
    return (backgroundColor ?? context.textColor).resolveDefaultAdwButtonColor(
      context,
      status,
      opaque: opaque,
    );
  }

  static Color? flatBackgroundColorBuilder(
    BuildContext context,
    Color? backgroundColor,
    AdwButtonStatus status, {
    bool opaque = false,
  }) {
    return (backgroundColor ?? (context.isDark ? Colors.black : Colors.white))
        .resolveFlatAdwButtonColor(
      context,
      status,
      opaque: opaque,
    );
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
    reset();
  }

  void reset() {
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
          onTapUp: (_) => setState(reset),
          onTapCancel: () => setState(() => _status = AdwButtonStatus.enabled),
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
              color: widget.backgroundColorBuilder?.call(
                context,
                widget.backgroundColor,
                _status,
                opaque: widget.opaque,
              ),
            ),
            child: DefaultTextStyle.merge(
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.6,
              ).merge(widget.textStyle),
              child: widget.child ??
                  widget.builder!(
                    context,
                    _status,
                    widget.child,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}

extension _AdwButtonBackgroundColor on Color {
  Color? resolveDefaultAdwButtonColor(
    BuildContext context,
    AdwButtonStatus status, {
    bool opaque = false,
  }) {
    if (opaque) {
      switch (status) {
        case AdwButtonStatus.enabled:
          return withOpacity(1);
        case AdwButtonStatus.enabledHovered:
          return withOpacity(context.isDark ? 0.85 : 0.88);
        case AdwButtonStatus.active:
          return withOpacity(context.isDark ? 0.80 : 0.84);
        case AdwButtonStatus.activeHovered:
          return withOpacity(context.isDark ? 0.76 : 0.80);
        case AdwButtonStatus.tapDown:
          return withOpacity(context.isDark ? 0.75 : 0.80);
      }
    } else {
      switch (status) {
        case AdwButtonStatus.enabled:
          return withOpacity(context.isDark ? 0.10 : 0.08);
        case AdwButtonStatus.enabledHovered:
          return withOpacity(context.isDark ? 0.15 : 0.12);
        case AdwButtonStatus.active:
          return withOpacity(context.isDark ? 0.20 : 0.16);
        case AdwButtonStatus.activeHovered:
          return withOpacity(context.isDark ? 0.24 : 0.20);
        case AdwButtonStatus.tapDown:
          return withOpacity(context.isDark ? 0.25 : 0.20);
      }
    }
  }

  Color? resolveFlatAdwButtonColor(
    BuildContext context,
    AdwButtonStatus status, {
    bool opaque = false,
  }) {
    switch (status) {
      case AdwButtonStatus.enabledHovered:
        return withOpacity(context.isDark ? 0.07 : 0.056);
      case AdwButtonStatus.active:
        return withOpacity(context.isDark ? 0.10 : 0.08);
      case AdwButtonStatus.activeHovered:
        return withOpacity(context.isDark ? 0.13 : 0.105);
      case AdwButtonStatus.tapDown:
        return withOpacity(context.isDark ? 0.19 : 0.128);
      case AdwButtonStatus.enabled:
        return null;
    }
  }
}

extension _ContextExt on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.light;
}
