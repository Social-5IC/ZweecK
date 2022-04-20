class Post {
  final String key;

  String date;

  final String image;

  int views;

  final String description;

  String? link;

  final List<String> tags;

  int likes;

  Post({
    required this.key,
    String? date,
    required this.image,
    this.views = 0,
    required this.description,
    this.link,
    required this.tags,
    this.likes = 0,
  }) : date = date ?? DateTime.now().toString();
}
