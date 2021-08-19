part of 'explore_recipe.dart';

class Ingredient {
  String imageUrl;
  String title;
  String source;

  Ingredient({
    required this.imageUrl,
    required this.title,
    required this.source,
  });

  Ingredient.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        title = json['title'],
        source = json['source'];
}
