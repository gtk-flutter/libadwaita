import 'package:flutter/material.dart';
import 'package:libadwaita/libadwaita.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({Key? key}) : super(key: key);

  @override
  _ListsPageState createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      center: true,
      controller: _controller,
      child: AdwPreferencesGroup(
        children: List.generate(
          15,
          (index) => ListTile(
            title: Text("Index $index"),
          ),
        ),
      ),
    );
  }
}
