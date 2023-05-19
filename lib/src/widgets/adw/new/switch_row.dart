import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AdwSwitchRow extends StatefulWidget {
  const AdwSwitchRow({
    super.key,
    this.start,
    required this.value,
    required this.onChanged,
    required this.title,
    this.subtitle,
    this.horizontalTitleGap = 8,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding,
  });

  /// The value of the switch
  final bool value;

  /// Executed when the switch is toggled
  final ValueSetter<bool> onChanged;

  /// The starting elemets of this row
  final Widget? start;

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
        onActivated: () => widget.onChanged(!widget.value),
        end: AdwSwitch(
          value: widget.value,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
