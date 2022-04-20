import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/core/services/api/api_service.dart';

class ApiServiceMock extends ApiService {
  @override
  Future<String> login(String mail, String password) async {
    return "123e4567-e89b-12d3-a456-426614174000";
  }

  @override
  Future<void> logout(String token) async {
    return;
  }

  @override
  Future<List<Post>> getPosts(String token, String filter) async {
    return [
      Post(
        description: 'dummy',
        image: 'image',
        tags: ['tag'],
        key: '123e4567-e89b-12d3-a456-426614174000',
      )
    ];
  }

  @override
  Future<Post> createPost(
    String token,
    String image,
    String description,
    List<String> tags,
    String? link,
  ) async {
    return Post(
      description: 'dummy',
      image: 'image',
      tags: ['tag'],
      key: '123e4567-e89b-12d3-a456-426614174000',
    );
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
  ) async {
    return "123e4567-e89b-12d3-a456-426614174000";
  }

  @override
  Future<void> deletePost(String token, String post) async {
    return;
  }

  @override
  Future<void> deleteUser(String token) async {
    return;
  }

  @override
  Future<void> dropLike(String token, String post) async {
    return;
  }

  @override
  Future<User> getUser(String token) async {
    return User(
      username: "dummy",
      name: "dummy",
      surname: "dummy",
      mail: "dummy@gmail.com",
      dateOfBirth: "1980-01-01 12:00:00",
      sex: "F",
      language: "EN",
    );
  }

  @override
  Future<void> like(String token, String post) async {
    return;
  }
}
