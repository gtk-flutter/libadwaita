import 'package:example/pages/run_demo_screen.dart';
import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class AboutDialogPage extends StatelessWidget {
  const AboutDialogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DemoScreen(
      image: const Icon(
        Icons.view_sidebar_rounded,
        size: 130,
      ),
      title: 'About Dialog',
      description: 'Something something',
      footer: AdwButton.pill(
        child: const Text('Run the demo'),
        onPressed: () {
          showDialog<Widget>(
            context: context,
            builder: (context) => AdwAboutWindow(
              supportUrl: 'https://example.org',
              issueUrl: 'https://example.org',
              developers: [
                AboutWindowPerson(
                  name: 'Angela Avery',
                  url: 'mailto:angela@example.com',
                ),
              ],
              designers: [
                AboutWindowPerson(
                  name: 'Ben Dover',
                  url: 'mailto:ben@dover.com',
                ),
              ],
              acknowledgements: [
                AboutWindowAcknowledgementSection(
                  name: 'Special Thanks to',
                  people: [
                    AboutWindowPerson(
                      name: 'My Cat',
                    ),
                  ],
                ),
              ],
              details: AboutWindowDetails(
                comments:
                    "Typeset is an app that doesn't exist and is used as an example content for this about window.",
                links: {
                  'Website': 'https://example.org',
                  'Documentation': 'https://example.org',
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
