import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/api/state_classes/success.dart';

class ApiServiceMock extends ApiService {
  @override
  Future<Either<Success, Failure>> test() async {
    // return Right(
    //   Failure.fromJson({
    //     "statusCode": 404,
    //     "timestamp": "1980-01-01 12:00:00",
    //     "error": 1,
    //     "message": "error",
    //   }),
    // );
    return Left(Success());
  }

  @override
  Future<Either<String, Failure>> login(String mail, String password) async {
    return const Left("123e4567-e89b-12d3-a456-426614174000");
  }

  @override
  Future<Either<Success, Failure>> logout(String token) async {
    return Left(Success());
  }

  @override
  Future<Either<List<Post>, Failure>> getPosts(String token,
      String filter) async {
    final List<dynamic> jsonFile =
    jsonDecode(await rootBundle.loadString("assets/posts.json"));
    print(jsonFile);
    final List<Future<Post>> jsonElaboratedPosts = jsonFile.map((object) async {
      // generate uuid
      object["key"] = const Uuid().v4();
      // cast tags to List<String>
      object["tags"] = object["tags"].cast<String>();
      // convert image to its base64
      object["image"] = base64.encode(
          Uint8List.view((await rootBundle.load(object["image"])).buffer));
      // return from named constructor
      return Post.fromJson(object);
    }).toList();


    final List<Post> jsonPosts = [];
    for (int i = 0; i < jsonElaboratedPosts.length; i++) {
      jsonPosts.add(await jsonElaboratedPosts[i]);
    }

    // final startIndex = Random().nextInt(jsonPosts.length - 10);
    // final posts = jsonPosts.sublist(startIndex, startIndex + 10).shuffle();
    final posts = List.generate(
      10,
          (index) => jsonPosts[Random().nextInt(jsonPosts.length)],
    );

    // return Right(
    //   Failure.fromJson({
    //     "statusCode": 400,
    //     "timestamp": "1980-01-01 12:00:00",
    //     "error": 1,
    //     "message": "error",
    //   }),
    // );
    // return const Left([]);
    // return Left(
    //   [
    //     Post(
    //       description: 'dummy1',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d4-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy2',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d5-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy3',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d6-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy4',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d7-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy5',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d8-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy6',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d9-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy7',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d0-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy8',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d1-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy9',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d2-a456-426614174000',
    //     ),
    //     Post(
    //       description: 'dummy0',
    //       image: image,
    //       tags: ['tag'],
    //       key: '123e4567-e89b-12d3-a456-426614174000',
    //     ),
    //   ],
    // );
    return Left(posts);
  }

  @override
  Future<Either<Post, Failure>> createPost(String token,
      String image,
      String description,
      List<String> tags,
      String? link,) async {
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
  Future<Either<String, Failure>> createUser(String username,
      String password,
      String mail,
      String name,
      String surname,
      String sex,
      String language,
      String birth,
      bool advertiser,) async {
    // return Right(
    //   Failure.fromJson({
    //     "statusCode": 400,
    //     "timestamp": "1980-01-01 12:00:00",
    //     "error": 1,
    //     "message": "error",
    //   }),
    // );
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
        username: "john_doe",
        name: "John",
        surname: "Doe",
        mail: "john.doe@gmail.com",
        birth: "1980-01-01 12:00:00",
        sex: "M",
        language: "EN",
      ),
    );
  }

  @override
  Future<Either<Success, Failure>> like(String token, String post) async {
    return Left(Success());
  }
}
