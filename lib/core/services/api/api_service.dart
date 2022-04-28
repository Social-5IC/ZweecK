import 'package:dartz/dartz.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/api/state_classes/success.dart';

abstract class ApiService {
  // test the server connection
  Future<Either<Success, Failure>> test();

  // login to the MZ, use the mail, password combination, return the token
  Future<Either<String, Failure>> login(String mail, String password);

  // logout from the MZ, take the token
  Future<Either<Success, Failure>> logout(String token);

  // create a user and automatically logged it,
  // take its attributes, return the token
  Future<Either<String, Failure>> createUser(String username,
      String password,
      String mail,
      String name,
      String surname,
      String sex,
      String language,
      String birth,
      bool advertiser,);

  // get the user of this session, take the token, return a user
  Future<Either<User, Failure>> getUser(String token);

  // delete the user, take the token
  Future<Either<Success, Failure>> deleteUser(String token);

  // create a post, take its attribute, return the Post with the new key
  Future<Either<Post, Failure>> createPost(String token,
      String image,
      String description,
      List<String> tags,
      String? link,);

  // get different posts, based on the filter,
  // take the token and the filter, return the posts
  Future<Either<List<Post>, Failure>> getPosts(String token, String filter);

  // delete a post, given its key, take the token and the key
  Future<Either<Success, Failure>> deletePost(String token, String post);

  // like a specific post, take the token and the post
  Future<Either<Success, Failure>> like(String token, String post);

  // drop the like from a specific post, take the token and the post
  Future<Either<Success, Failure>> dropLike(String token, String post);
}
