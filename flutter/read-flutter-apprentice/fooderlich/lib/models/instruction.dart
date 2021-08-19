part of 'explore_recipe.dart';

class Instruction {
  String imageUrl;
  String description;
  int durationInMinutes;

  Instruction({
    required this.imageUrl,
    required this.description,
    required this.durationInMinutes,
  });

  Instruction.fromJson(Map<String, dynamic> json)
      : imageUrl = json['imageUrl'],
        description = json['description'],
        durationInMinutes = json['durationInMinutes'] ?? 0;

  static parseJson(Map<String, dynamic> json) => Instruction.fromJson(json);
}
