import 'style_classes_home.dart';
import 'package:flutter/material.dart';
import 'package:adwaita/adwaita.dart';

class StyleClassesWindow extends StatelessWidget {
  const StyleClassesWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AdwaitaThemeData.light(),
      darkTheme: AdwaitaThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: StyleClassesHomePage(),
    );
  }
}
