import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/explore_recipe.dart';

import 'author_card.dart';

class Card2 extends StatelessWidget {
  final ExploreRecipe recipe;

  const Card2({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = FooderlichTheme.lightTextTheme;

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
        child: Column(
          children: [
            AuthorCard(
              name: recipe.authorName ?? '',
              imageProvider: AssetImage(recipe.profileImage ?? ''),
              title: recipe.role ?? '',
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: Text(recipe.title ?? '', style: textTheme.headline1),
                    bottom: 16,
                    right: 16,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(recipe.subtitle ?? '',
                          style: textTheme.headline1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
