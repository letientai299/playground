import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';

import 'author_card.dart';

class Card2 extends StatelessWidget {
  const Card2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = FooderlichTheme.lightTextTheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag5.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            AuthorCard(
              name: 'Mike Katz',
              imageProvider: AssetImage('assets/author_katz.jpeg'),
              title: 'Smoothie Connoisseur',
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: Text('Recipe', style: textTheme.headline1),
                    bottom: 10,
                    right: 10,
                  ),
                  Positioned(
                    bottom: 20,
                    left: 10,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text('Smoothies', style: textTheme.headline1),
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
