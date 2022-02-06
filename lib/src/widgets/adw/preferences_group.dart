import 'package:flutter/material.dart';

class AdwPreferencesGroup extends StatelessWidget {
  const AdwPreferencesGroup({
    Key? key,
    required this.children,
    this.borderRadius = 12,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
  }) : super(key: key);

  const AdwPreferencesGroup.credits({
    Key? key,
    required this.children,
    this.borderRadius = 12,
    this.title,
    this.titleStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    this.description,
    this.descriptionStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 5),
  }) : super(key: key);

  final List<Widget> children;
  final double borderRadius;
  final String? title;
  final String? description;
  final EdgeInsets padding;

  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  style: titleStyle ?? Theme.of(context).textTheme.headline6,
                ),
                if (description != null)
                  Text(
                    description!,
                    style: descriptionStyle ??
                        Theme.of(context).textTheme.bodyText2,
                  ),
                const SizedBox(height: 8),
              ],
            ],
          ),
        ),
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
              (index) => index.isEven
                  ? children[index ~/ 2]
                  : const Divider(height: 4),
            ),
          ),
        ),
      ],
    );
  }
}
