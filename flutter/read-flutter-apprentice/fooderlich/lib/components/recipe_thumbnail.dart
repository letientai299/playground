import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  final SimpleRecipe recipe;

  const RecipeThumbnail({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              child: Image.asset(
                recipe.dishImage,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 10),
          Text(recipe.title, style: theme.bodyText1),
          Text(recipe.duration, style: theme.bodyText1),
        ],
      ),
    );
  }
}
