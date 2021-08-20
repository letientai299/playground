import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

import 'fooderlich_theme.dart';
import 'home.dart';

void main() {
  runApp(Fooderlich());
}

class Fooderlich extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();

    return MaterialApp(
      title: 'Fooderlich',
      theme: theme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
          ChangeNotifierProvider(create: (context) => GroceryManager()),
        ],
        child: Home(),
      ),
    );
  }
}
