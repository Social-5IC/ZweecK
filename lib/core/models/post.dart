class Post {
  final String key;

  String date;

  final String image;

  int views;

  final String description;

  String? link;

  final List<String> tags;

  int likes;

  bool youLiked;

  Post(
      {required this.key,
      String? date,
      required this.image,
      this.views = 0,
      required this.description,
      this.link,
      required this.tags,
      this.likes = 0,
      this.youLiked = false})
      : date = date ?? DateTime.now().toString();

  Post.fromJson(Map<String, dynamic> json)
      : key = json['key'],
        date = json['date'] ?? DateTime.now().toString(),
        image = json['image'],
        views = json['views'] ?? 0,
        description = json['description'],
        link = json['link'],
        tags = json['tags'],
        likes = json['likes'] ?? 0,
        youLiked = json['youLiked'] ?? false;
}
