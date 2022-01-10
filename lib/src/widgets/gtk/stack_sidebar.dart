import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:libadwaita/src/utils/colors.dart';

class AdwStackSidebar extends StatefulWidget {
  const AdwStackSidebar({
    Key? key,
    required this.sidebar,
    required this.content,
    this.seperator,
    required this.onContentPopupClosed,
    this.breakpoint = 800,
    this.sidebarWidth = 250,
    this.contentIndex,
    this.fullContentBuilder,
  }) : super(key: key);

  final Widget sidebar;
  final Widget content;
  final Widget? seperator;

  /// Keeps track of the content index
  final int? contentIndex;

  /// Called when content screen is closed and sidebar is shown
  final void Function() onContentPopupClosed;

  /// The breakpoint for small devices
  final double breakpoint;

  /// sidebar has a width of `sidebarWidth`
  /// Rest is allocated to content
  final double sidebarWidth;

  // Content builder on smaller screen
  final Function(int? contentIndex, Widget content)? fullContentBuilder;

  @override
  _AdwStackSidebarState createState() => _AdwStackSidebarState();
}

class _AdwStackSidebarState extends State<AdwStackSidebar> {
  bool _popupNotOpen = true;

  bool get canSplitPanes =>
      widget.breakpoint < MediaQuery.of(context).size.width;

  /// Loads and removes the popup page for content on small screens
  Future<void> loadContentPage(BuildContext context) async {
    if (_popupNotOpen) {
      _popupNotOpen = false;
      SchedulerBinding.instance!.addPostFrameCallback((_) async {
        // sets _popupNotOpen to true after popup is closed
        await Navigator.of(context)
            .push<void>(
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                body: widget.fullContentBuilder != null
                    ? widget.fullContentBuilder!(
                        widget.contentIndex,
                        widget.content,
                      ) as Widget?
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
      SchedulerBinding.instance!
          .addPostFrameCallback((_) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (canSplitPanes) {
      _closePopup();
      final content = <Widget>[
        SizedBox(
          width: widget.sidebarWidth,
          child: widget.sidebar,
        ),
        widget.seperator ?? Container(width: 1, color: context.borderColor),
        Flexible(child: widget.content),
      ];
      return Row(
        children: content,
      );
    } else {
      loadContentPage(context);
      return Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: widget.sidebar,
          ),
        ],
      );
    }
  }
}
