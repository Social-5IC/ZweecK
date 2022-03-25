class Post {
  final String description;

  String date;

  final String image;

  int views;

  int likes;

  final int? clicks;

  final List<String> tags;

  Post({
    required this.description,
    String? date,
    required this.image,
    this.views = 0,
    this.clicks,
    required this.tags,
    this.likes = 0,
  }) : date = date ?? DateTime.now().toString();
}