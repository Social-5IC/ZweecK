import 'package:dartz/dartz.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/api/state_classes/success.dart';

class ApiServiceMock extends ApiService {
  @override
  Future<Either<String, Failure>> login(String mail, String password) async {
    return const Left("123e4567-e89b-12d3-a456-426614174000");
  }

  @override
  Future<Either<Success, Failure>> logout(String token) async {
    return Left(Success());
  }

  @override
  Future<Either<List<Post>, Failure>> getPosts(
      String token, String filter) async {
    return Left(
      [
        Post(
          description: 'dummy',
          image: 'image',
          tags: ['tag'],
          key: '123e4567-e89b-12d3-a456-426614174000',
        )
      ],
    );
  }

  @override
  Future<Either<Post, Failure>> createPost(
    String token,
    String image,
    String description,
    List<String> tags,
    String? link,
  ) async {
    return Left(
      Post(
        description: 'dummy',
        image: 'image',
        tags: ['tag'],
        key: '123e4567-e89b-12d3-a456-426614174000',
      ),
    );
  }

  @override
  Future<Either<String, Failure>> createUser(
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
    return const Left("123e4567-e89b-12d3-a456-426614174000");
  }

  @override
  Future<Either<Success, Failure>> deletePost(String token, String post) async {
    return Left(Success());
  }

  @override
  Future<Either<Success, Failure>> deleteUser(String token) async {
    return Left(Success());
  }

  @override
  Future<Either<Success, Failure>> dropLike(String token, String post) async {
    return Left(Success());
  }

  @override
  Future<Either<User, Failure>> getUser(String token) async {
    return Left(
      User(
        username: "dummy",
        name: "dummy",
        surname: "dummy",
        mail: "dummy@gmail.com",
        birth: "1980-01-01 12:00:00",
        sex: "F",
        language: "EN",
      ),
    );
  }

  @override
  Future<Either<Success, Failure>> like(String token, String post) async {
    return Left(Success());
  }
}
