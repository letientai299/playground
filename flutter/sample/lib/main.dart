import 'package:flutter/material.dart';
import 'package:sample/samples.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Samples")),
        body: SampleList(),
      ),
    ),
  );
}

class SampleList extends StatefulWidget {
  @override
  _SampleListState createState() => _SampleListState();
}

class _SampleListState extends State<SampleList> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: _children());
  }

  List<Widget> _children() {
    var samples = _sampleAppTiles();
    return ListTile.divideTiles(tiles: samples, context: context).toList();
  }

  List<Widget> _sampleAppTiles() {
    return samples()
        .map((e) => ListTile(title: Text(e.name), onTap: () => _open(e.app)))
        .toList();
  }

  void _open(Widget app) {
    var nav = Navigator.of(context);
    nav.push(MaterialPageRoute(builder: (context) {
      return app;
    }));
  }
}
