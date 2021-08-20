import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/recipes_grid_view.dart';
import 'package:fooderlich/models/models.dart';

class RecipesScreen extends StatelessWidget {
  final service = MockFooderlichService();

  RecipesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: service.getRecipes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        var data = snapshot.data as List<SimpleRecipe>;
        return RecipesGridView(data);
      },
    );
  }
}
