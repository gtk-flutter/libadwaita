import 'package:flutter/material.dart';
import 'package:libadwaita/src/utils/colors.dart';
import 'package:libadwaita/src/widgets/adw/button.dart';
import 'package:popover_gtk/popover_gtk.dart';

/// This is the stateful widget that the main application instantiates.
class AdwComboRow extends StatefulWidget {
  const AdwComboRow({
    Key? key,
    this.choices = const [],
    this.start,
    this.end,
    required this.selectedIndex,
    required this.onSelected,
    required this.title,
    this.subtitle,
    this.autofocus = false,
    this.enabled = true,
    this.contentPadding,
  }) : super(key: key);

  final List<String> choices;
  final int selectedIndex;
  final ValueSetter<int> onSelected;
  final Widget? start;
  final Widget? end;
  final String title;
  final String? subtitle;
  final bool autofocus;
  final bool enabled;
  final EdgeInsets? contentPadding;

  @override
  State<AdwComboRow> createState() => _AdwComboRowState();
}

/// This is the private State class that goes with MyStatefulWidget.
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
            child: ListTile(
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              contentPadding: widget.contentPadding,
              leading: widget.start,
              title: Text(widget.title),
              subtitle: widget.subtitle != null && widget.subtitle!.isNotEmpty
                  ? Text(widget.subtitle!)
                  : null,
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
    Key? key,
    this.choices = const [],
    required this.onSelected,
    required this.selectedIndex,
  }) : super(key: key);

  final List<String> choices;
  final ValueSetter<int> onSelected;
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
