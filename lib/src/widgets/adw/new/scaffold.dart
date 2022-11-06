import 'package:flutter/material.dart';
import 'package:libadwaita/src/controllers/flap_controller.dart';
import 'package:libadwaita/src/utils/colors.dart';
import 'package:libadwaita/src/widgets/widgets.dart';
import 'package:libadwaita_core/libadwaita_core.dart';

class AdwScaffold extends StatefulWidget {
  const AdwScaffold({
    Key? key,
    required this.body,
    this.flap,
    this.flapStyle,
    this.flapOptions,
    this.flapController,
    @Deprecated('headerbar is deprecated, use the properties separately')
        AdwHeaderBar? Function(Widget?)? headerbar,
    this.viewSwitcher,
    this.viewSwitcherConstraint,
    this.headerBarStyle,
    this.start,
    this.title,
    this.end,
    required this.actions,
    this.controls,
  }) : super(key: key);

  final Widget body;

  final AdwSidebar Function(bool isDrawer)? flap;

  final FlapController? flapController;

  final FlapStyle? flapStyle;
  final FlapOptions? flapOptions;

  final HeaderBarStyle? headerBarStyle;

  final List<Widget>? start;
  final Widget? title;
  final List<Widget>? end;

  final AdwActions actions;
  final AdwControls? controls;

  final Widget? viewSwitcher;
  final double? viewSwitcherConstraint;

  @override
  State<AdwScaffold> createState() => _AdwScaffoldState();
}

class _AdwScaffoldState extends State<AdwScaffold> {
  FlapController? _flapController;

  @override
  void initState() {
    super.initState();
    _flapController = widget.flapController ?? FlapController();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <=
        (widget.viewSwitcherConstraint ?? 600);
    final isFlapVisible = widget.flap != null;
    final isViewSwitcherVisible = widget.viewSwitcher != null;

    final flap = isFlapVisible
        ? SizedBox(
            width: 200,
            child: Drawer(
              elevation: 25,
              child: widget.flap!(true),
            ),
          )
        : null;

    return SafeArea(
      child: Column(
        children: [
          AdwHeaderBar(
            actions: widget.actions,
            controls: widget.controls,
            title: isViewSwitcherVisible && !isMobile
                ? widget.viewSwitcher
                : widget.title,
            end: widget.end ?? [],
            start: widget.start ?? [],
            style: widget.headerBarStyle ?? const HeaderBarStyle(),
          ),
          Expanded(
            child: Scaffold(
              drawerEnableOpenDragGesture: _flapController
                      ?.shouldEnableDrawerGesture(FlapPosition.start) ??
                  false,
              endDrawerEnableOpenDragGesture: _flapController
                      ?.shouldEnableDrawerGesture(FlapPosition.end) ??
                  false,
              onDrawerChanged: _flapController?.onDrawerChanged,
              drawer: flap,
              endDrawer: flap,
              body: isFlapVisible
                  ? AdwFlap(
                      flap: widget.flap!(false),
                      controller: widget.flapController,
                      style: widget.flapStyle,
                      options: widget.flapOptions,
                      child: widget.body,
                    )
                  : widget.body,
              bottomNavigationBar: isViewSwitcherVisible && isMobile
                  ? Container(
                      height: widget.headerBarStyle != null
                          ? widget.headerBarStyle!.height
                          : 51,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: context.borderColor,
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          widget.viewSwitcher!,
                        ],
                      ),
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
