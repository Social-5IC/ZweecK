import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/api/state_classes/success.dart';

const String _baseUrl = "http://localhost/api";

class ApiServiceHttp extends ApiService {
  final authAPI = Uri.parse("$_baseUrl/auth");
  final userAPI = Uri.parse("$_baseUrl/user");
  final postAPI = Uri.parse("$_baseUrl/post");
  final likeAPI = Uri.parse("$_baseUrl/like");

  @override
  Future<Either<Success, Failure>> test() async {
    final response = await http.get(Uri.parse(_baseUrl));
    return response.statusCode == 200
        ? Left(
            Success(),
          )
        : Right(
            Failure.fromJson({"statusCode": response.statusCode}),
          );
  }

  @override
  Future<Either<String, Failure>> login(
    String mail,
    String password,
  ) async {
    Map<String, String> headers = {
      "mail": mail,
      "password": password,
    };

    final response = await http.post(
      authAPI,
      headers: headers,
    );

    Map<String, dynamic> body = jsonDecode(response.body);

    return response.statusCode == 200
        ? Left(
            body['token'],
          )
        : Right(
            Failure.fromJson(
              {
                "statusCode": response.statusCode,
                ...body,
              },
            ),
          );
  }

  @override
  Future<Either<Success, Failure>> logout(
    String token,
  ) async {
    Map<String, String> headers = {
      "token": token,
    };

    final response = await http.delete(
      authAPI,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Left(
        Success(),
      );
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);

      return Right(
        Failure.fromJson(
          {
            "statusCode": response.statusCode,
            ...body,
          },
        ),
      );
    }
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
    Map<String, String> headers = {
      "username": username,
      "password": password,
      "mail": mail,
      "name": name,
      "surname": surname,
      "sex": sex,
      "language": language,
      "birth": birth,
      "advertiser": advertiser.toString(),
    };

    final response = await http.post(
      userAPI,
      headers: headers,
    );

    Map<String, dynamic> body = jsonDecode(response.body);

    return response.statusCode == 200
        ? Left(
            body['token'],
          )
        : Right(
            Failure.fromJson(
              {
                "statusCode": response.statusCode,
                ...body,
              },
            ),
          );
  }

  @override
  Future<Either<User, Failure>> getUser(
    String token,
  ) async {
    Map<String, String> headers = {
      "token": token,
    };

    final response = await http.get(
      userAPI,
      headers: headers,
    );

    Map<String, dynamic> body = jsonDecode(response.body);

    return response.statusCode == 200
        ? Left(
            User.fromJson(body),
          )
        : Right(
            Failure.fromJson(
              {
                "statusCode": response.statusCode,
                ...body,
              },
            ),
          );
  }

  @override
  Future<Either<Success, Failure>> deleteUser(
    String token,
  ) async {
    Map<String, String> headers = {
      "token": token,
    };

    final response = await http.delete(
      userAPI,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Left(
        Success(),
      );
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);

      return Right(
        Failure.fromJson(
          {
            "statusCode": response.statusCode,
            ...body,
          },
        ),
      );
    }
  }

  @override
  Future<Either<Post, Failure>> createPost(
    String token,
    String image,
    String description,
    List<String> tags,
    String? link,
  ) async {
    Map<String, String> headers = {
      "token": token,
      "image": image,
      "description": description,
      "tags": "[" + tags.join(",") + "]",
      "link": link ?? '',
    };

    headers.removeWhere((key, value) => value.isEmpty);

    final response = await http.post(
      postAPI,
      headers: headers,
    );

    Map<String, dynamic> body = jsonDecode(response.body);

    return response.statusCode == 200
        ? Left(
            Post(
              key: body['key'],
              image: image,
              description: description,
              tags: tags,
              link: link,
            ),
          )
        : Right(
            Failure.fromJson(
              {
                "statusCode": response.statusCode,
                ...body,
              },
            ),
          );
  }

  @override
  Future<Either<List<Post>, Failure>> getPosts(
    String token,
    String filter,
  ) async {
    Map<String, String> headers = {
      "token": token,
      "filter": filter,
    };

    final response = await http.get(
      postAPI,
      headers: headers,
    );

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> posts = jsonDecode(response.body);

      return Left(
        posts.map((post) => Post.fromJson(post)).toList(),
      );
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);

      return Right(
        Failure.fromJson(
          {
            "statusCode": response.statusCode,
            ...body,
          },
        ),
      );
    }
  }

  @override
  Future<Either<Success, Failure>> deletePost(
    String token,
    String post,
  ) async {
    Map<String, String> headers = {
      "token": token,
      "post": post,
    };

    final response = await http.delete(
      postAPI,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Left(
        Success(),
      );
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);

      return Right(
        Failure.fromJson(
          {
            "statusCode": response.statusCode,
            ...body,
          },
        ),
      );
    }
  }

  @override
  Future<Either<Success, Failure>> like(
    String token,
    String post,
  ) async {
    Map<String, String> headers = {
      "token": token,
      "post": post,
    };

    final response = await http.post(
      likeAPI,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Left(
        Success(),
      );
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);

      return Right(
        Failure.fromJson(
          {
            "statusCode": response.statusCode,
            ...body,
          },
        ),
      );
    }
  }

  @override
  Future<Either<Success, Failure>> dropLike(
    String token,
    String post,
  ) async {
    Map<String, String> headers = {
      "token": token,
      "post": post,
    };

    final response = await http.delete(
      likeAPI,
      headers: headers,
    );

    if (response.statusCode == 200) {
      return Left(
        Success(),
      );
    } else {
      Map<String, dynamic> body = jsonDecode(response.body);

      return Right(
        Failure.fromJson(
          {
            "statusCode": response.statusCode,
            ...body,
          },
        ),
      );
    }
  }
}
