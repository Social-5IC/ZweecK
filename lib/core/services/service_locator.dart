import 'package:get_it/get_it.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/mock/mock_api_service.dart';

final getIt = GetIt.instance;

setUpServiceLocator() {
  getIt.registerLazySingleton<ApiService>(() => ApiServiceMock());
}