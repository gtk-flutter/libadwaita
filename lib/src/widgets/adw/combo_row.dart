import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:popover_gtk/popover_gtk.dart';

class AdwComboRow extends StatefulWidget {
  const AdwComboRow({
    super.key,
    this.choices = const [],
    this.start,
    this.end,
    required this.selectedIndex,
    required this.onSelected,
    required this.title,
    this.subtitle,
    this.horizontalTitleGap = 8,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding,
  });

  /// The choices available for this combo row
  final List<String> choices;

  /// The index of the selected choice
  final int selectedIndex;

  /// Executed when a choice is selected
  final ValueSetter<int> onSelected;

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
  State<AdwComboRow> createState() => _AdwComboRowState();
}

class _AdwComboRowState extends State<AdwComboRow> {
  _AdwComboRowState();

  final GlobalKey<_AdwComboButtonState> _comboButtonState =
      GlobalKey<_AdwComboButtonState>();

  late AdwComboButton button;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(1),
      hoverColor: context.hoverColor,
      onTap: () {
        if (_comboButtonState.currentState!.active) {
          Navigator.of(context).pop();
          _comboButtonState.currentState!.active = false;
        } else {
          _comboButtonState.currentState?.show();
        }
      },
      child: Row(
        children: [
          Expanded(
            child: AdwActionRow(
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              contentPadding: widget.contentPadding,
              horizontalTitleGap: widget.horizontalTitleGap,
              start: widget.start,
              title: widget.title,
              subtitle: widget.subtitle,
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    widget.choices[widget.selectedIndex],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 5),
                AdwComboButton(
                  key: _comboButtonState,
                  choices: widget.choices,
                  selectedIndex: widget.selectedIndex,
                  onSelected: (val) {
                    widget.onSelected(val);
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdwComboButton extends StatefulWidget {
  const AdwComboButton({
    super.key,
    this.choices = const [],
    required this.onSelected,
    required this.selectedIndex,
  });

  /// The choices available for this combo row
  final List<String> choices;

  /// Executed when a choice is selected
  final ValueSetter<int> onSelected;

  /// The index of the selected choice
  final int selectedIndex;

  @override
  State<AdwComboButton> createState() => _AdwComboButtonState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _AdwComboButtonState extends State<AdwComboButton> {
  _AdwComboButtonState();

  bool active = false;

  @override
  Widget build(BuildContext context) => const Icon(Icons.arrow_drop_down);

  void show() {
    showPopover(
      context: context,
      arrowHeight: 14,
      barrierColor: Colors.transparent,
      shadow: [
        BoxShadow(
          color: context.borderColor,
          blurRadius: 6,
        ),
      ],
      bodyBuilder: (_) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            widget.choices.length,
            (int index) => AdwButton.flat(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.choices[index],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (index == widget.selectedIndex)
                    const Icon(Icons.check, size: 20),
                ],
              ),
              onPressed: () {
                widget.onSelected(index);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
      width: 200,
      backgroundColor: Theme.of(context).cardColor,
    ).whenComplete(() => setState(() => active = false));
  }
}
