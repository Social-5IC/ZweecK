import 'package:flutter/material.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/service_locator.dart';
import 'package:zweeck/core/services/storage/storage_service.dart';
import 'package:zweeck/view/welcome/welcome_view.dart';

class HomeViewModel extends ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();
  final StorageService _storageService = getIt<StorageService>();

  bool readyFlag = false;

  Failure? error;

  String _token = "";

  Future init(BuildContext context) async {
    // test connection
    dynamic result = (await _apiService.test()).fold((l) => l, (r) => r);
    if (result is Failure) {
      error = result;
      readyFlag = true;
      notifyListeners();
      return;
    }

    // validate session
    _token = await _storageService.getToken();

    if (_token.isEmpty) {
      // go to welcome page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeView(),
        ),
      ).then((_) => init(context));
    }

    readyFlag = true;
    notifyListeners();
  }
}
