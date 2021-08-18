import 'package:flutter/material.dart';

import 'fooderlich_theme.dart';

void main() {
  runApp(Fooderlich());
}

class Fooderlich extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.dark();

    return MaterialApp(
      title: 'Fooderlich',
      theme: theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fooderlich', style: theme.textTheme.headline6),
        ),
        body: Center(
          child: Text("Let's get cooking", style: theme.textTheme.headline1),
        ),
      ),
    );
  }
}
