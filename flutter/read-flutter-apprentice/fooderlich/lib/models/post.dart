class Post {
  String profileImageUrl;
  String comment;
  String foodPictureUrl;
  String timestamp;

  Post({
    required this.profileImageUrl,
    required this.comment,
    required this.foodPictureUrl,
    required this.timestamp,
  });

  static Post parseJson(Map<String, dynamic> json) => Post.fromJson(json);

  Post.fromJson(Map<String, dynamic> json)
      : profileImageUrl = json['profileImageUrl'],
        foodPictureUrl = json['foodPictureUrl'],
        timestamp = json['timestamp'],
        comment = json['comment'];
}
