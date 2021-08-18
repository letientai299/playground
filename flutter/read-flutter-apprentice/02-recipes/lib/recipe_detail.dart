import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'recipe.dart';

class RecipeDetail extends StatefulWidget {
  const RecipeDetail({Key? key, required this.recipe}) : super(key: key);

  final Recipe recipe;

  @override
  _RecipeDetailState createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  int _sliderVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.label),
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: Image(image: AssetImage(widget.recipe.imageUrl)),
          ),
          const SizedBox(height: 4),
          Text(widget.recipe.label, style: const TextStyle(fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: widget.recipe.ingredients.length,
              itemBuilder: (context, index) {
                final ing = widget.recipe.ingredients[index];
                return Text(
                  '${ing.quantity * _sliderVal} ${ing.measure} ${ing.name}',
                );
              },
            ),
          ),
          Slider(
            min: 1,
            max: 10,
            divisions: 10,
            label: '${_sliderVal * widget.recipe.servings} servings',
            onChanged: (double value) {
              setState(() {
                _sliderVal = value.round();
              });
            },
            value: _sliderVal.toDouble(),
            activeColor: Colors.green,
          ),
        ],
      )),
    );
  }
}
