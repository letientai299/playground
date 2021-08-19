import 'package:flutter/material.dart';
import 'package:fooderlich/models/explore_recipe.dart';

class Card1 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card1({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(recipe.backgroundImage ?? ''),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Text(recipe.subtitle ?? '', style: textTheme.bodyText1),
            Positioned(
              child: Text(recipe.title ?? '', style: textTheme.headline5),
              top: 20,
            ),
            Positioned(
              child: Text(recipe.message ?? '', style: textTheme.bodyText1),
              bottom: 30,
              right: 5,
            ),
            Positioned(
              child: Text(recipe.authorName ?? '', style: textTheme.bodyText1),
              right: 5,
              bottom: 10,
            ),
          ],
        ),
      ),
    );
  }
}
