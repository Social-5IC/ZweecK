import 'package:flutter/cupertino.dart';
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

  late bool _personalZone;

  bool get personalZone => _personalZone;

  String _title = "";

  String get title => _title;

  String _emptyListPlaceHolder = "";

  String get emptyListPlaceHolder => _emptyListPlaceHolder;

  init(String filter) async {
    _token = await _storageService.getToken();
    _filter = filter;
    _personalZone = _filter == "Y";

    switch (filter) {
      case "F":
        _title = "Your following posts";
        _emptyListPlaceHolder = "Follow someone!";
        break;
      case "S":
        _title = "Suggested for you";
        _emptyListPlaceHolder = "Nothing for you yet!";
        break;
      case "Y":
        _title = "Your posts";
        _emptyListPlaceHolder = "No post";
        break;
    }

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

  Future<Failure?> createPost(
    String image,
    String description,
    List<String> tags,
    String? link,
  ) async {
    (await _apiService.createPost(_token, image, description, tags, link)).fold(
      (post) {
        _posts.add(post);
      },
      (failure) {
        error = failure;
      },
    );

    notifyListeners();
    return error;
  }

  Future deletePost(
    String key,
  ) async {
    (await _apiService.deletePost(_token, key)).fold(
      (post) {
        _posts.removeWhere((element) => element.key == key);
      },
      (failure) {
        error = failure;
      },
    );

    notifyListeners();
  }
}
