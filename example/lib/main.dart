import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as r;

import 'content.dart';

const useRiverpod = false;
final gnomeThemeProvider =
    r.ChangeNotifierProvider((ref) => GnomeThemeProvider());

void main() => runApp(useRiverpod
    ? const r.ProviderScope(child: MyRiverpodApp())
    : const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GnomeThemeProvider>(
      create: (_) => GnomeThemeProvider(),
      builder: (context, widget) {
        return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            home: Stack(
              fit: StackFit.expand,
              children: [
                MyHomePage(
                  title: 'Gtk + Flutter Demo',
                  gnomeTheme: Provider.of<GnomeThemeProvider>(context).theme,
                ),
                diagonalBanner('Provider'),
              ],
            ),
            theme: Provider.of<GnomeThemeProvider>(context).getTheme());
      },
    );
  }
}

class MyRiverpodApp extends r.ConsumerWidget {
  const MyRiverpodApp({Key? key}) : super(key: key);

  @override
  Widget build(context, ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Stack(
        fit: StackFit.expand,
        children: [
          MyHomePage(
            title: 'Gtk + Flutter Demo',
            gnomeTheme: ref.watch(gnomeThemeProvider).theme,
          ),
          diagonalBanner('Riverpod'),
        ],
      ),
      theme: ref.watch(gnomeThemeProvider).getTheme(),
    );
  }
}

Widget diagonalBanner(String text) {
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
      padding: const EdgeInsets.only(bottom: 55, right: 50),
      child: Banner(
        message: text,
        textStyle: const TextStyle(fontSize: 18),
        location: BannerLocation.topStart,
      ),
    ),
  );
}
