import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AdwSwitchRow extends StatefulWidget {
  const AdwSwitchRow({
    Key? key,
    this.start,
    this.end,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.horizontalTitleGap = 8,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding,
  }) : super(key: key);

  /// The index of the selected choice
  final bool value;

  /// Executed when a choice is selected
  final ValueSetter<bool?> onChanged;

  /// The starting elemets of this row
  final Widget? start;

  /// The ending elements of this row
  final Widget? end;

  /// The title of this row
  final String title;

  /// The subtitle of this row
  final String? subtitle;

  /// Whether to focus automatically when this widget is visible
  /// defaults to false
  final bool autofocus;

  /// Whether this combo row is enabled or not, defaults to true
  final bool enabled;

  /// The horizontal gap between the titles and the leading/trailing widgets.
  final double horizontalTitleGap;

  /// The padding b/w content of this Combo row
  final EdgeInsets? contentPadding;

  @override
  State<AdwSwitchRow> createState() => _AdwSwitchRowState();
}

class _AdwSwitchRowState extends State<AdwSwitchRow> {
  _AdwSwitchRowState();

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: AdwActionRow(
        title: widget.title,
        contentPadding: widget.contentPadding,
        end: AdwSwitch(
          value: widget.value,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
