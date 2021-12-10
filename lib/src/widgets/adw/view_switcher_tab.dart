import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AdwViewSwitcherTab extends StatefulWidget {
  final ViewSwitcherData data;
  final ViewSwitcherStyle style;
  final bool isSelected;
  final VoidCallback? onTap;

  const AdwViewSwitcherTab({
    Key? key,
    required this.data,
    required this.isSelected,
    required this.style,
    required this.onTap,
  }) : super(key: key);

  @override
  State<AdwViewSwitcherTab> createState() => _AdwViewSwitcherTabState();
}

class _AdwViewSwitcherTabState extends State<AdwViewSwitcherTab> {
  bool isHovered = false;

  void onEnter(_) {
    setState(() {
      isHovered = true;
    });
  }

  void onExit(_) {
    setState(() {
      isHovered = false;
    });
  }

  Color getColor() {
    if (isHovered) {
      return Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).backgroundColor.lighten(0.15)
          : Theme.of(context).backgroundColor.darken(0.005);
    } else if (widget.isSelected) {
      return Theme.of(context).brightness == Brightness.dark
          ? Theme.of(context).backgroundColor.lighten(0.1)
          : Theme.of(context).backgroundColor.darken(0.1);
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: MouseRegion(
          onEnter: onEnter,
          onExit: onExit,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              color: getColor(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
                child: Row(
                  children: [
                    Icon(
                      widget.data.icon,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.data.title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            letterSpacing: 1.0,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    /* return style == ViewSwitcherStyle.desktop */
    /*     ? Padding( */
    /*         padding: const EdgeInsets.symmetric(horizontal: 24.0), */
    /*         child: Row( */
    /*           children: [ */
    /*             if (data.icon != null) icon, */
    /*             if (data.icon != null && data.title != null) */
    /*               const SizedBox(width: 8), */
    /*             if (data.title != null) */
    /*               Text( */
    /*                 data.title!, */
    /*                 style: Theme.of(context).textTheme.bodyText2?.copyWith( */
    /*                       fontWeight: */
    /*                           isSelected ? FontWeight.bold : FontWeight.normal, */
    /*                     ), */
    /*               ), */
    /*           ], */
    /*         ), */
    /*       ) */
    /*     : Padding( */
    /*         padding: const EdgeInsets.symmetric(horizontal: 21.0), */
    /*         child: Column( */
    /*           mainAxisAlignment: MainAxisAlignment.center, */
    /*           children: [ */
    /*             if (data.icon != null) icon, */
    /*             if (data.icon != null && data.title != null) */
    /*               const SizedBox(height: 2), */
    /*             if (data.title != null) */
    /*               Text( */
    /*                 data.title!, */
    /*                 style: Theme.of(context).textTheme.bodyText2?.copyWith( */
    /*                       fontSize: 12, */
    /*                       fontWeight: */
    /*                           isSelected ? FontWeight.bold : FontWeight.normal, */
    /*                     ), */
    /*               ), */
    /*           ], */
    /*         ), */
    /*       ); */
  }
}
