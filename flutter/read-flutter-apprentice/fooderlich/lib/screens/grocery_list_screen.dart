import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/grocery_manager.dart';

class GroceryListScreen extends StatelessWidget {
  final GroceryManager manager;

  GroceryListScreen(this.manager);

  @override
  Widget build(BuildContext context) {
    final items = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = items[index];
          return GroceryTile(
            key: Key(item.id),
            item: item,
            onComplete: (change) => manager.completeItem(index, change),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: items.length,
      ),
    );
  }
}
