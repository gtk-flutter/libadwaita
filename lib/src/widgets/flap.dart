import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:libadwaita/src/utils/colors.dart';

class AdwFlap extends StatefulWidget {
  final Widget flap;
  final Widget content;
  final Widget? seperator;

  /// Keeps track of the content's open state
  final bool showContent;

  /// Keeps track of the content header title
  final String? contentTitle;

  /// Called when content screen is closed and flap is shown
  final void Function() onContentPopupClosed;

  /// The breakpoint for small devices
  final double breakpoint;

  /// pane1 has a width of `panelWidth`
  ///
  /// pane2 `total - panelWidth`
  final double panelWidth;

  // Pane 2 builder on smaller screen
  final Function(String? pane2Name, Widget pane2)? fullPane2Builder;

  const AdwFlap({
    Key? key,
    this.showContent = false,
    required this.flap,
    required this.content,
    this.seperator,
    required this.onContentPopupClosed,
    this.breakpoint = 800,
    this.panelWidth = 250,
    this.contentTitle,
    this.fullPane2Builder,
  }) : super(key: key);

  @override
  _AdwFlapState createState() => _AdwFlapState();
}

class _AdwFlapState extends State<AdwFlap> {
  bool _popupNotOpen = true;

  bool get canSplitPanes => widget.breakpoint < MediaQuery.of(context).size.width;

  /// Loads and removes the popup page for pane2 on small screens
  void loadPane2Page(BuildContext context) async {
    if (widget.showContent && _popupNotOpen) {
      _popupNotOpen = false;
      SchedulerBinding.instance!.addPostFrameCallback((_) async {
        // sets _popupNotOpen to true after popup is closed
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                body: widget.fullPane2Builder != null
                    ? widget.fullPane2Builder!(widget.contentTitle, widget.content)
                    : widget.content,
              );
            },
            fullscreenDialog: true,
          ),
        )
            .then((_) {
          // less code than wapping in a WillPopScope
          _popupNotOpen = true;
          // preserves value if screen canSplitPanes
          if (!canSplitPanes) widget.onContentPopupClosed();
        });
      });
    }
  }

  /// closes popup wind
  void _closePopup() {
    if (!_popupNotOpen) {
      SchedulerBinding.instance!.addPostFrameCallback((_) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (canSplitPanes && widget.showContent) {
      _closePopup();
      return Row(
        children: [
          SizedBox(
            width: widget.panelWidth,
            child: widget.flap,
          ),
          widget.seperator ?? VerticalDivider(color: context.borderColor),
          Flexible(
            child: widget.content,
          ),
        ],
      );
    } else {
      loadPane2Page(context);
      return Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 100,
            child: widget.flap,
          ),
        ],
      );
    }
  }
}
