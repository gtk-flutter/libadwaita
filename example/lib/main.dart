import 'package:flutter/material.dart';
import 'package:gtk/gtk.dart';

import 'content.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GnomeTheme(
      isDark: false,
      builder: (context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(),
        theme: GnomeTheme.of(context).themeData,
      ),
    );
  }
}
