part 'ingredient.dart';
part 'instruction.dart';

class RecipeCardType {
  static const String card1 = 'card1';
  static const String card2 = 'card2';
  static const String card3 = 'card3';
}

class ExploreRecipe {
  String? cardType;
  String? title;
  String? subtitle;
  String? backgroundImage;
  String? backgroundImageSource;
  String? message;
  String? authorName;
  String? role;
  String? profileImage;
  int? durationInMinutes;
  String? dietType;
  int? calories;
  List<String>? tags;
  String? description;
  String? source;
  List<Ingredient>? ingredients;
  List<Instruction>? instructions;

  ExploreRecipe({
    this.cardType,
    this.title,
    this.subtitle,
    this.backgroundImage,
    this.backgroundImageSource,
    this.message,
    this.authorName,
    this.role,
    this.profileImage,
    this.durationInMinutes,
    this.dietType,
    this.calories,
    this.tags,
    this.description,
    this.source,
    this.ingredients,
    this.instructions,
  });

  ExploreRecipe.fromJson(Map<String, dynamic> json)
      : cardType = json['cardType'],
        title = json['title'],
        subtitle = json['subtitle'],
        backgroundImage = json['backgroundImage'],
        backgroundImageSource = json['backgroundImageSource'],
        message = json['message'],
        authorName = json['authorName'],
        role = json['role'],
        profileImage = json['profileImage'],
        durationInMinutes = json['durationInMinutes'],
        dietType = json['dietType'],
        calories = json['calories'],
        tags = json['tags'].cast<String>(),
        description = json['description'],
        source = json['source'],
        ingredients = json['ingredients'].map(Ingredient.parseJson).toList(),
        instructions = json['instructions'].map(Instruction.parseJson).toList();

  static ExploreRecipe parseJson(Map<String, dynamic> json) =>
      ExploreRecipe.fromJson(json);
}
