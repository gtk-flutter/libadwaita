import 'package:flutter/material.dart';
import 'package:libadwaita/src/widgets/widgets.dart';
import 'package:libadwaita_core/libadwaita_core.dart';

class GtkDialog extends StatelessWidget {
  const GtkDialog({
    Key? key,
    this.headerBarStyle,
    this.start,
    this.title,
    this.end,
    this.actions,
    this.controls,
    this.padding,
    this.constraints,
    this.height,
    this.width,
    required this.child,
  }) : super(key: key);

  final HeaderBarStyle? headerBarStyle;

  final List<Widget>? start;
  final Widget? title;
  final List<Widget>? end;

  final AdwActions? actions;
  final AdwControls? controls;

  final EdgeInsets? padding;
  final Widget child;

  final BoxConstraints? constraints;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: width ?? 600,
        height: height ?? 600,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AdwHeaderBar(
                title: title,
                start: start ?? [],
                end: end ?? [],
                actions: actions ??
                    AdwActions(
                      onClose: Navigator.of(context).pop,
                    ),
                controls: controls,
                style: headerBarStyle ??
                    const HeaderBarStyle(
                      autoPositionWindowButtons: false,
                      isTransparent: true,
                    ),
              ),
              Flexible(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
