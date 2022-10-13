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

  /// List of all the elements in this group
  final List<Widget> children;

  /// The border radius of this visit
  final double borderRadius;

  /// The title of this preferences group
  final String? title;

  /// The description of this preferences group
  final String? description;

  /// The padding around this preferences group
  final EdgeInsets padding;

  /// The style of the title text of this group
  final TextStyle? titleStyle;

  /// The style of the description text of this group
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
                  style: titleStyle ?? Theme.of(context).textTheme.headline5,
                ),
                if (description != null)
                  Text(
                    description!,
                    style: descriptionStyle ??
                        Theme.of(context).textTheme.bodyText2,
                  ),
                const SizedBox(height: 12),
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
