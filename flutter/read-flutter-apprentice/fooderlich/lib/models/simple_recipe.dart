class SimpleRecipe {
  String dishImage;
  String title;
  String duration;
  String source;
  List<String> information;

  SimpleRecipe({
    required this.dishImage,
    required this.title,
    required this.duration,
    required this.source,
    required this.information,
  });

  SimpleRecipe.fromJson(Map<String, dynamic> json)
      : dishImage = json['dishImage'],
        title = json['title'],
        duration = json['duration'],
        source = json['source'],
        information = json['information'].cast<String>();
}
