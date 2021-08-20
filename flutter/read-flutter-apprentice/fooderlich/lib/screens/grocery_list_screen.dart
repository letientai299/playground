import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/screens/grocery_item_screen.dart';

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
          return InkWell(
            child: GroceryTile(
              key: Key(item.id),
              item: item,
              onComplete: (change) => manager.completeItem(index, change),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return GroceryItemScreen(
                    originalItem: item,
                    onCreate: (item) {},
                    onUpdate: (item) {
                      manager.updateItem(item, index);
                      Navigator.pop(context);
                    },
                  );
                }),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: items.length,
      ),
    );
  }
}
