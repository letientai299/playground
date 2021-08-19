import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = FooderlichTheme.darkTextTheme;

    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag3.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.book, color: Colors.white, size: 40),
                  const SizedBox(height: 8),
                  Text('Recipe Trends', style: textTheme.headline2),
                  const SizedBox(height: 30),
                  Center(
                    child: Wrap(children: makeChips(textTheme)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> makeChips(TextTheme textTheme) {
    final rand = math.Random();

    return [
      'Sashimi',
      'Sushi',
      'Beef',
      'Pig',
      'Bean',
      'Healthy',
      'Vegan',
      'Greens',
      'Meat',
      'Asian',
      'Bakery',
      'Chinese',
      'Japanese',
      'Vietnamese',
    ]
        .map((e) => Chip(
              label: Text(e, style: textTheme.bodyText1),
              backgroundColor: Colors.black.withOpacity(0.6),
              onDeleted: rand.nextInt(3) < 1 ? () {} : null,
            ))
        .toList()
          ..shuffle();
  }
}
