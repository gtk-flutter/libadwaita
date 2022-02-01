import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AdwAboutWindow extends StatelessWidget {
  const AdwAboutWindow({
    Key? key,
    required this.appIcon,
    this.endIcon,
    this.width = 360,
    this.headerbar,
    this.copyright,
    this.issueTrackerLink,
    this.license,
    this.credits,
  }) : super(key: key);

  /// The HeaderBar for About Window, defaults to transparent [AdwHeaderBar]
  final AdwHeaderBar? headerbar;

  /// The width of the about window dialog
  final double width;

  /// The app icon to show in the about window
  final Widget appIcon;

  /// The end icon of The Credits and Legal button,
  /// defaults to chevron_right Material Icon
  final Widget? endIcon;

  /// The Copyright notice for Legal Screen
  final String? copyright;

  /// The link for the issue tracker
  final String? issueTrackerLink;

  /// The License for the app
  final String? license;

  /// The content's of Credits screen
  final List<AdwPreferencesGroup>? credits;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final data = snapshot.hasData ? snapshot.data : null;
        final isNotNull = data != null;
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  headerbar ??
                      AdwHeaderBar(
                        onClose: Navigator.of(context).pop,
                        isTransparent: true,
                      ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    width: 80,
                    child: appIcon,
                  ),
                  Text(
                    isNotNull ? data!.appName : '---',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Column(
                      children: [
                        AdwPreferencesGroup(
                          borderRadius: 12,
                          children: [
                            AdwActionRow(
                              title: 'Version',
                              end: Text(
                                isNotNull ? data!.version : '0',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AdwPreferencesGroup(
                          borderRadius: 12,
                          children: [
                            AdwActionRow(
                              title: 'Credits',
                              end: endIcon ?? const Icon(Icons.chevron_right),
                            ),
                            AdwActionRow(
                              title: 'Legal',
                              end: endIcon ?? const Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
