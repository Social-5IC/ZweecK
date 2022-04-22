import 'package:flutter/foundation.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/service_locator.dart';
import 'package:zweeck/core/services/storage/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();
  final StorageService _storageService = getIt<StorageService>();

  bool errorFlag = false;

  Failure? error;

  String _token = "";

  List<Post> _followingPosts = [];

  List<Post> get followingPosts => _followingPosts;

  List<Post> _suggestedPosts = [];

  List<Post> get suggestedPosts => _suggestedPosts;

  Future init() async {
    _token = await _storageService.getToken();
    if (_token.isEmpty) {
      // Navigator push to sign up page
    } else {
      // GET following posts
      (await _apiService.getPosts(_token, "F")).fold(
        (posts) {
          _followingPosts = posts;
        },
        (failure) {
          error = failure;
          errorFlag = true;
        },
      );
      // GET suggested posts
      (await _apiService.getPosts(_token, "S")).fold(
        (posts) {
          _suggestedPosts = posts;
        },
        (failure) {
          error = failure;
          errorFlag = true;
        },
      );
      notifyListeners();
    }
  }
}
