import 'package:zweeck/core/models/post.dart';
import 'package:zweeck/core/services/api/api_service.dart';

class ApiServiceMock extends ApiService {
  
  @override
  Future<List<Post>> getYourPosts() async {
    return [
      Post(description: 'dummy', image: 'image', tags: ['tag'])
    ];
  }
  
}