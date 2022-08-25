import 'package:flutter/material.dart';
import 'package:libadwaita/src/widgets/widgets.dart';
import 'package:libadwaita_core/libadwaita_core.dart';

class GtkDialog extends StatelessWidget {
  const GtkDialog({
    super.key,
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
    required this.children,
  });

  final HeaderBarStyle? headerBarStyle;

  final List<Widget>? start;
  final Widget? title;
  final List<Widget>? end;

  final AdwActions? actions;
  final AdwControls? controls;

  final EdgeInsets? padding;
  final List<Widget> children;

  final BoxConstraints? constraints;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ConstrainedBox(
          constraints: constraints ??
              BoxConstraints(
                maxWidth: width ?? 600,
                maxHeight: height ?? 600,
              ),
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
                child: SingleChildScrollView(
                  padding: padding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
