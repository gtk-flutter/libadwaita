import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

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
  const AdwAboutWindow({Key? key}) : super(key: key);

  @override
  State<AdwAboutWindow> createState() => _AdwAboutWindowState();
}

class _AdwAboutWindowState extends State<AdwAboutWindow> {
  late GlobalKey<NavigatorState> navigatorKey;

  String currentRoute = '';

  @override
  void initState() {
    navigatorKey = GlobalKey();
    super.initState();
  }

  bool isVisible(String name) {
    return name != "/" && name != "";
  }

  void goTo(String route, BuildContext context) {
    setState(() {
      Navigator.of(context).pushNamed(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GtkDialog(
      width: 300,
      start: [
        AnimatedOpacity(
          opacity: isVisible(currentRoute) ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: AbsorbPointer(
            absorbing: !isVisible(currentRoute),
            child: AdwHeaderButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 24,
              ),
              onPressed: () {
                navigatorKey.currentState?.pop();
                setState(() {
                  currentRoute = '/';
                });
              },
            ),
          ),
        )
      ],
      child: Navigator(
        key: navigatorKey,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          currentRoute = settings.name ?? '';

          Widget page = Builder(
            builder: (context) => _AdwAboutDialogHome(
              goTo: (name) => goTo(name, context),
            ),
          );

          switch (settings.name) {
            case '/':
              break;
            case '/new':
              page = const _AdwAboutDialogPatchNotes();
              break;
          }

          return PageRouteBuilder<Widget>(
            pageBuilder: (context, _, __) => page,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1, 0);
              const end = Offset.zero;
              const curve = Curves.ease;

              final tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            settings: settings,
          );
        },
      ),
    );
  }
}

class _AdwAboutDialogHome extends StatelessWidget {
  const _AdwAboutDialogHome({Key? key, required this.goTo}) : super(key: key);

  final Function(String) goTo;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        Align(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: Image.asset(
              'assets/logo.png',
              width: 100,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          child: const Text(
            "Typeset",
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Align(
          child: const Text(
            "Angela Avery",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Align(
          child: AdwButton.pill(
            padding: const EdgeInsets.only(
              top: 6,
              bottom: 8,
              left: 18,
              right: 18,
            ),
            textStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: const Text('1.2.3'),
          ),
        ),
        const SizedBox(height: 20),
        AdwPreferencesGroup(
          children: [
            AdwActionRow(
              title: 'What\'s new',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              onActivated: () {
                goTo("/new");
              },
              end: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            AdwActionRow(
              title: 'Details',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              onActivated: () {},
              end: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AdwPreferencesGroup(
          children: [
            AdwActionRow(
              title: 'Support Questions',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              onActivated: () {},
              end: const Icon(
                Icons.open_in_new_rounded,
                size: 16,
              ),
            ),
            AdwActionRow(
              title: 'Report an issue',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              onActivated: () {},
              end: const Icon(
                Icons.open_in_new_rounded,
                size: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        AdwPreferencesGroup(
          children: [
            AdwActionRow(
              title: 'Credits',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              onActivated: () {},
              end: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            AdwActionRow(
              title: 'Legal',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              onActivated: () {},
              end: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
            AdwActionRow(
              title: 'Acknowledgements',
              titleStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              onActivated: () {},
              end: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }
}

class _AdwAboutDialogPatchNotes extends StatelessWidget {
  const _AdwAboutDialogPatchNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).dialogBackgroundColor,
      height: double.infinity,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: [
          Text(
            "Version 1.2.0",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text("""
This release adds the following features:

• Added a way to export fonts.
• Better support for monospace fonts.
• Added a way to preview italic text.
• Bug fixes and performance improvements.
• Translation updates.
                    """),
        ],
      ),
    );
  }
}
