import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup name generator'),
        actions: [IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)],
      ),
      body: Center(
        child: _buildSuggestions(),
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index.isOdd) return Divider();

          final i = index ~/ 2;
          if (i >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[i]);
        });
  }

  Widget _buildRow(WordPair wp) {
    final alreadySaved = _saved.contains(wp);
    return ListTile(
      title: _buildWordPair(wp),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? _saved.remove(wp) : _saved.add(wp);
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((e) => ListTile(title: _buildWordPair(e)));
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(tiles: tiles, context: context).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: Text('Saved suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  Widget _buildWordPair(WordPair wp) {
    return Row(
      children: [
        Text(
          wp.first.titleCase(),
          style: _biggerFont.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          wp.second.titleCase(),
          style: _biggerFont,
        )
      ],
    );
  }
}

extension StringCase on String {
  String titleCase() => this[0].toUpperCase() + substring(1, length);
}
