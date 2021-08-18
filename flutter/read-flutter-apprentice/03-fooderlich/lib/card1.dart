import 'package:flutter/material.dart';

class Card1 extends StatelessWidget {
  const Card1({Key? key}) : super(key: key);

  final String category = "Editor's choice";
  final String title = "The Art of Dough";
  final String desc = "Learn to make the perfect bread.";
  final String chef = "Tai Le";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag1.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            Text(category, style: textTheme.bodyText1),
            Positioned(
              child: Text(title, style: textTheme.headline5),
              top: 20,
            ),
            Positioned(
              child: Text(desc, style: textTheme.bodyText1),
              bottom: 30,
              right: 5,
            ),
            Positioned(
              child: Text(chef, style: textTheme.bodyText1),
              right: 5,
              bottom: 10,
            ),
          ],
        ),
      ),
    );
  }
}
