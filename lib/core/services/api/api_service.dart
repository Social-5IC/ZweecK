import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/models/user.dart';

abstract class ApiService {
  // login to the MZ, use the mail, password combination, return the token
  Future<String> login(String mail, String password);

  // logout from the MZ, take the token
  Future<void> logout(String token);

  // create a user and automatically logged it,
  // take its attributes, return the token
  Future<String> createUser(String username,
      String password,
      String mail,
      String name,
      String surname,
      String sex,
      String language,
      String birth,
      bool advertiser,);

  // get the user of this session, take the token, return a user
  Future<User> getUser(String token);

  // delete the user, take the token
  Future<void> deleteUser(String token);

  // create a post, take its attribute, return the Post with the new key
  Future<Post> createPost(String token,
      String image,
      String description,
      List<String> tags,
      String? link,);

  // get different posts, based on the filter,
  // take the token and the filter, return the posts
  Future<List<Post>> getPosts(String token, String filter);

  // delete a post, given its key, take the token and the key
  Future<void> deletePost(String token, String post);

  // like a specific post, take the token and the post
  Future<void> like(String token, String post);

  // drop the like from a specific post, take the token and the post
  Future<void> dropLike(String token, String post);
}
