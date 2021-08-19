import 'package:flutter/material.dart';
import 'package:fooderlich/components/recipe_thumbnail.dart';
import 'package:fooderlich/models/models.dart';

class RecipesGridView extends StatelessWidget {
  final List<SimpleRecipe> recipes;

  const RecipesGridView(this.recipes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: recipes.length,
        itemBuilder: (context, index) =>
            RecipeThumbnail(recipe: recipes[index]),
      ),
    );
  }
}
