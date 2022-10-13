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
    required this.children,
  }) : super(key: key);

  /// The style of the header bar in this dialog
  final HeaderBarStyle? headerBarStyle;

  /// The starting elements of the header bar in this dialog
  final List<Widget>? start;

  /// The title of the header bar in this dialog
  final Widget? title;

  /// The ending elements of the header bar in this dialog
  final List<Widget>? end;

  /// The window button actions of the header bar in this dialog
  final AdwActions? actions;

  /// The window button controls of the header bar in this dialog
  final AdwControls? controls;

  /// The padding around the childrens of this dialog
  final EdgeInsets? padding;

  /// The list of child widgets in this dialog
  final List<Widget> children;

  /// The box constraints of this dialog
  final BoxConstraints? constraints;

  /// The height of this dialog, will be ignored when constraints are provided
  final double? height;

  /// The width of this dialog, will be ignored when constraints are provided
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
