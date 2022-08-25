import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_core/libadwaita_core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// The About window for your app in libadwaita style
/// Use this with [showDialog] and onPressed / onTap / onActivated
/// parameter of a button
/// Example:
/// ```
/// showDialog<Widget>(
///   context: context,
///   builder: (ctx) => AdwAboutWindow(
///     issueTrackerLink: 'link',
///     appIcon: Image.asset('assets/logo.png'),
///     credits: [],
///   ),
/// ),
/// ```
class AdwAboutWindow extends StatefulWidget {
  const AdwAboutWindow({
    super.key,
    required this.appIcon,
    this.appName,
    this.appVersion,
    this.nextPageIcon,
    this.launchEndIcon,
    this.width = 360,
    @Deprecated('headerbar is deprecated, use the properties separately')
        AdwHeaderBar? Function(Widget?)? headerbar,
    this.headerBarStyle,
    this.start,
    this.end,
    this.actions,
    this.controls,
    this.copyright,
    this.issueTrackerLink,
    this.license,
    this.credits,
  });

  final HeaderBarStyle? headerBarStyle;

  final List<Widget>? start;
  final List<Widget>? end;

  final AdwActions? actions;
  final AdwControls? controls;

  /// The width of the about window dialog
  final double width;

  /// The app icon to show in the about window
  final Widget appIcon;

  /// The app name to show in the about window, not required
  final String? appName;

  /// The app version to show in the about window, not required
  final String? appVersion;

  /// The end icon of The Credits and Legal button,
  /// defaults to chevron_right Material Icon
  final Widget? nextPageIcon;

  /// The end icon of Report an issue button
  final Widget? launchEndIcon;

  /// The Copyright notice for Legal Screen
  final String? copyright;

  /// The link for the issue tracker
  final String? issueTrackerLink;

  /// The License for the app
  final Text? license;

  /// The content's of Credits screen
  final List<AdwPreferencesGroup>? credits;

  @override
  State<AdwAboutWindow> createState() => _AdwAboutWindowState();
}

class _AdwAboutWindowState extends State<AdwAboutWindow> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    const commonPadding = EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 8,
    );
    final leading = currentPage != 0
        ? AdwHeaderButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => setState(() => currentPage = 0),
          )
        : const SizedBox();
    final text = currentPage != 0
        ? Text(currentPage == 1 ? 'Credits' : 'Legal')
        : const SizedBox();

    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final data = snapshot.hasData ? snapshot.data : null;
        final isNotNull = data != null;
        return GtkDialog(
          constraints: BoxConstraints(
            maxWidth: widget.width,
            minHeight: 350,
            maxHeight: 400,
          ),
          title: text,
          start: [
            leading,
            if (widget.start != null) ...widget.start!,
          ],
          end: widget.end ?? [],
          actions: widget.actions ??
              AdwActions(
                onClose: Navigator.of(context).pop,
              ),
          controls: widget.controls,
          headerBarStyle: widget.headerBarStyle ??
              const HeaderBarStyle(
                isTransparent: true,
              ),
          padding: commonPadding,
          children: currentPage == 0
              ? [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 3),
                    width: 80,
                    child: widget.appIcon,
                  ),
                  Text(
                    widget.appName ?? (isNotNull ? data.appName : '---'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  AdwPreferencesGroup(
                    children: [
                      AdwActionRow(
                        title: 'Version',
                        end: Text(
                          widget.appVersion ?? (isNotNull ? data.version : '0'),
                        ),
                      ),
                      if (widget.issueTrackerLink != null)
                        AdwActionRow(
                          title: 'Report an issue',
                          onActivated: () => launchUrl(
                            Uri.parse(widget.issueTrackerLink!),
                          ),
                          end: widget.launchEndIcon ??
                              const Icon(
                                Icons.open_in_new_outlined,
                                size: 20,
                              ),
                        ),
                    ],
                  ),
                  if ((widget.credits != null) ||
                      widget.copyright != null ||
                      widget.license != null) ...[
                    const SizedBox(height: 8),
                    AdwPreferencesGroup(
                      children: [
                        if (widget.credits != null)
                          AdwActionRow(
                            title: 'Credits',
                            onActivated: () => setState(() => currentPage = 1),
                            end: widget.nextPageIcon ??
                                const Icon(
                                  Icons.chevron_right,
                                ),
                          ),
                        if (widget.copyright != null || widget.license != null)
                          AdwActionRow(
                            title: 'Legal',
                            onActivated: () => setState(() => currentPage = 2),
                            end: widget.nextPageIcon ??
                                const Icon(
                                  Icons.chevron_right,
                                ),
                          ),
                      ],
                    ),
                  ],
                ]
              : currentPage == 1
                  ? widget.credits!
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: e,
                        ),
                      )
                      .toList()
                  : [
                      if (widget.copyright != null) Text(widget.copyright!),
                      const SizedBox(height: 5),
                      if (widget.license != null) widget.license!,
                    ],
        );
      },
    );
  }
}
