import 'package:zweeck/core/models/post.dart';

abstract class ApiService {
    Future<List<Post>> getYourPosts();
}