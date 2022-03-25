
import 'package:flutter/foundation.dart';
import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/service_locator.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();

  List<Post> _posts = [];

  List<Post> get posts => _posts;

  Future init() async {
    _posts = await _apiService.getYourPosts();
    notifyListeners();
  }
}