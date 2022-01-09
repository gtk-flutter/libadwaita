// ignore_for_file: require_trailing_commas

import 'package:flutter/material.dart';
import 'package:libadwaita/src/internal/popover.dart';
import 'package:libadwaita/src/utils/colors.dart';

/// This is the stateful widget that the main application instantiates.
class AdwComboRow extends StatefulWidget {
  final List<String> choices;
  final Widget? start;
  final Widget? end;
  final String title;
  final String? subtitle;
  final bool autofocus;
  final bool enabled;
  final EdgeInsets? contentPadding;

  const AdwComboRow(
      {Key? key,
      this.choices = const [],
      this.start,
      this.end,
      required this.title,
      this.subtitle,
      this.autofocus = false,
      this.enabled = true,
      this.contentPadding})
      : super(key: key);

  @override
  State<AdwComboRow> createState() => _AdwComboRowState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _AdwComboRowState extends State<AdwComboRow> {
  bool taped = false;
  int selected = 0;
  final GlobalKey<_AdwComboButtonState> _comboButtonState =
      GlobalKey<_AdwComboButtonState>();

  late AdwComboButton button;

  _AdwComboRowState();

  @override
  void initState() {
    button = AdwComboButton(
      key: _comboButtonState,
      choices: widget.choices,
      getSelected: () {
        return selected;
      },
      setSelected: (select) {
        setState(() {
          selected = select;
        });
      },
    );
    super.initState();
  }

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
          Expanded(child: Container()),
          SizedBox(
            width: 50,
            child: Text(
              widget.choices[selected],
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 5),
          button,
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class AdwComboButton extends StatefulWidget {
  final List<String> choices;
  final ValueSetter<int> setSelected;
  final ValueGetter<int> getSelected;

  const AdwComboButton(
      {Key? key,
      this.choices = const [],
      required this.setSelected,
      required this.getSelected})
      : super(key: key);

  @override
  State<AdwComboButton> createState() => _AdwComboButtonState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _AdwComboButtonState extends State<AdwComboButton> {
  bool active = false;

  _AdwComboButtonState();

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.arrow_drop_down);
  }

  void show() {
    showPopover(
      context: context,
      child: Column(
        children: List.generate(widget.choices.length, (int index) {
          return ListTile(
            title: Text(widget.choices[index]),
            trailing:
                index == widget.getSelected() ? const Icon(Icons.check) : null,
            onTap: () {
              setState(() {
                widget.setSelected(
                  index,
                ); //if you want to assign the index somewhere to check
              });
              Navigator.of(context).pop();
            },
          );
        }),
      ),
      width: 150,
      height: null,
      backgroundColor: Theme.of(context).cardColor,
      contentOffset: const Offset(0, 4),
    ).whenComplete(() => setState(() => active = false));
  }
}
