import 'package:flutter/foundation.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/service_locator.dart';
import 'package:zweeck/core/services/storage/storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();
  final StorageService _storageService = getIt<StorageService>();

  String _token = "";

  List<Post> _followingPosts = [];

  List<Post> get followingPosts => _followingPosts;

  List<Post> _suggestedPosts = [];

  List<Post> get suggestedPosts => _suggestedPosts;

  Future init() async {
    _token = await _storageService.getToken();
    if (_token.isNotEmpty) {
      _followingPosts = await _apiService.getPosts(_token, "F");
      _suggestedPosts = await _apiService.getPosts(_token, "S");
    } // if empty Navigator push to sign up page
    notifyListeners();
  }
}
