import 'package:flutter/material.dart';
import 'package:gtk/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class GtkApp extends StatelessWidget {
  final TransitionBuilder? builder;

  const GtkApp({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GnomeThemeProvider>(
        create: (_) => GnomeThemeProvider(), builder: builder);
  }
}
