import 'package:flutter/material.dart';

class AdwPreferencesGroup extends StatelessWidget {
  final List<Widget> children;
  final double borderRadius;
  final String? title;
  final String? description;

  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const AdwPreferencesGroup({
    Key? key,
    required this.children,
    this.borderRadius = 10,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!,
              style: titleStyle ?? Theme.of(context).textTheme.headline6),
          if (description != null)
            Text(
              description!,
              style: descriptionStyle ?? Theme.of(context).textTheme.bodyText2,
            ),
          const SizedBox(height: 14),
        ],
        // This is a hack while waiting for https://github.com/flutter/flutter/issues/94785
        // to be fixed
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              2 * children.length - 1,
              (index) => index.isEven ? children[index ~/ 2] : const Divider(),
            ),
          ),
        ),
      ],
    );
  }
}
