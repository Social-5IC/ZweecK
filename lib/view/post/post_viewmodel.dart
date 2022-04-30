import 'package:flutter/foundation.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/service_locator.dart';
import 'package:zweeck/core/services/storage/storage_service.dart';

class PostViewModel extends ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();
  final StorageService _storageService = getIt<StorageService>();

  bool readyFlag = false;

  Failure? error;

  String _token = "";

  String _filter = "";

  final List<Post> _posts = [];

  List<Post> get posts => _posts;

  init(String filter) async {
    _token = await _storageService.getToken();
    _filter = filter;

    retrievePosts();

    readyFlag = true;
    notifyListeners();
  }

  Future retrievePosts() async {
    (await _apiService.getPosts(_token, _filter)).fold(
      (posts) {
        _posts.addAll(posts);
      },
      (failure) {
        error = failure;
      },
    );
    notifyListeners();
  }

  Future likePost(String key) async {
    (await _apiService.like(_token, key)).fold(
      (success) {
        _posts.firstWhere((element) => element.key == key)
          ..youLiked = true
          ..likes += 1;
      },
      (failure) {
        error = failure;
      },
    );
    notifyListeners();
  }

  Future dropLike(String key) async {
    (await _apiService.dropLike(_token, key)).fold(
      (success) {
        _posts.firstWhere((element) => element.key == key)
          ..youLiked = false
          ..likes -= 1;
      },
      (failure) {
        error = failure;
      },
    );
    notifyListeners();
  }
}
