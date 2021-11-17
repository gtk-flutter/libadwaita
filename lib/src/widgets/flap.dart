import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:libadwaita/src/utils/colors.dart';

enum FoldPolicy { never, always, auto }
enum FlapPosition { start, end }

class AdwFlap extends StatefulWidget {
  final Widget flap;
  final Widget content;
  final Widget? seperator;

  final FoldPolicy foldPolicy;
  final FlapPosition flapPosition;

  /// Keeps track of the content's open state
  final bool showContent;

  /// Keeps track of the content index
  final int? contentIndex;

  /// Called when content screen is closed and flap is shown
  final void Function() onContentPopupClosed;

  /// The breakpoint for small devices
  final double breakpoint;

  /// flap has a width of `flapWidth`
  /// Rest is allocated to content
  final double flapWidth;

  // Content builder on smaller screen
  final Function(int? contentIndex, Widget content)? fullContentBuilder;

  const AdwFlap({
    Key? key,
    this.showContent = false,
    required this.flap,
    required this.content,
    this.seperator,
    this.foldPolicy = FoldPolicy.auto,
    this.flapPosition = FlapPosition.start,
    required this.onContentPopupClosed,
    this.breakpoint = 800,
    this.flapWidth = 250,
    this.contentIndex,
    this.fullContentBuilder,
  }) : super(key: key);

  @override
  _AdwFlapState createState() => _AdwFlapState();
}

class _AdwFlapState extends State<AdwFlap> {
  bool _popupNotOpen = true;

  bool get canSplitPanes =>
      widget.foldPolicy == FoldPolicy.never ||
      widget.foldPolicy == FoldPolicy.auto && widget.breakpoint < MediaQuery.of(context).size.width;

  /// Loads and removes the popup page for content on small screens
  void loadContentPage(BuildContext context) async {
    if (widget.showContent && _popupNotOpen) {
      _popupNotOpen = false;
      SchedulerBinding.instance!.addPostFrameCallback((_) async {
        // sets _popupNotOpen to true after popup is closed
        Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return Scaffold(
                body: widget.fullContentBuilder != null
                    ? widget.fullContentBuilder!(widget.contentIndex, widget.content)
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
      List<Widget> content = [
        SizedBox(
          width: widget.flapWidth,
          child: widget.flap,
        ),
        widget.seperator ?? Container(width: 1, color: context.borderColor),
        Flexible(child: widget.content),
      ];
      return Row(
        children: widget.flapPosition == FlapPosition.start ? content : content.reversed.toList(),
      );
    } else {
      loadContentPage(context);
      return Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: widget.flap,
          ),
        ],
      );
    }
  }
}
