import 'package:flutter/material.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/service_locator.dart';
import 'package:zweeck/core/services/storage/storage_service.dart';

class WelcomeViewModel extends ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();
  final StorageService _storageService = getIt<StorageService>();

  Failure? error;
  String _token = "";

  Future<Failure?> signUp(
    BuildContext context,
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
    (await _apiService.createUser(
      username,
      password,
      mail,
      name,
      surname,
      sex,
      language,
      birth,
      advertiser,
    ))
        .fold(
      (token) {
        _token = token;
      },
      (failure) {
        error = failure;
      },
    );

    // error case
    if (error != null) {
      notifyListeners();
      return error!;
    }

    // safe zone
    await _storageService.saveToken(_token);
    Navigator.pop(context);
    notifyListeners();
    return null;
  }

  Future<Failure?> login(
    BuildContext context,
    String mail,
    String password,
  ) async {
    (await _apiService.login(
      mail,
      password,
    ))
        .fold(
      (token) {
        _token = token;
      },
      (failure) {
        error = failure;
      },
    );

    // error case
    if (error != null) {
      notifyListeners();
      return error!;
    }

    // safe zone
    await _storageService.saveToken(_token);
    Navigator.pop(context);
    notifyListeners();
    return null;
  }
}
