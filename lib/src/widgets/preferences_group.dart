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
    this.borderRadius = 18,
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
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.transparent,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              2 * children.length - 1,
              (index) => index.isEven
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: index ~/ 2 == 0 ? 4 : 0,
                        bottom: index ~/ 2 == children.length - 1 ? 4 : 0,
                      ),
                      child: children[index ~/ 2],
                    )
                  : const Divider(),
            ),
          ),
        ),
      ],
    );
  }
}
