import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/core/services/api/api_service.dart';

class ApiServiceHttp extends ApiService {
  @override
  Future<Post> createPost(
    String token,
    String image,
    String description,
    List<String> tags,
    String? link,
  ) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<String> createUser(
    String username,
    String password,
    String mail,
    String name,
    String surname,
    String sex,
    String language,
    String birth,
    bool advertiser,
  ) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<void> deletePost(String token, String post) {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String token) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<void> dropLike(String token, String post) {
    // TODO: implement dropLike
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> getPosts(String token, String filter) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<User> getUser(String token) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> like(String token, String post) {
    // TODO: implement like
    throw UnimplementedError();
  }

  @override
  Future<String> login(String mail, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout(String token) {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
