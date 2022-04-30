import 'package:flutter/material.dart';
import 'package:zweeck/core/models/user.dart';
import 'package:zweeck/core/services/api/api_service.dart';
import 'package:zweeck/core/services/api/state_classes/failure.dart';
import 'package:zweeck/core/services/service_locator.dart';
import 'package:zweeck/core/services/storage/storage_service.dart';
import 'package:zweeck/view/home/home_view.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService _apiService = getIt<ApiService>();
  final StorageService _storageService = getIt<StorageService>();

  bool _readyFlag = false;

  bool get readyFlag => _readyFlag;

  Failure? _error;

  Failure? get error => _error;

  String _token = "";

  late final User _user;

  User get user => _user;

  init() async {
    _token = await _storageService.getToken();

    retrieveUser();

    _readyFlag = true;
    notifyListeners();
  }

  Future retrieveUser() async {
    (await _apiService.getUser(_token)).fold(
          (user) {
        _user = user;
      },
          (failure) {
        _error = failure;
      },
    );
    notifyListeners();
  }

  Future logout(BuildContext context) async {
    dynamic result = (await _apiService.logout(_token)).fold(
          (success) => success,
          (failure) => failure,
    );

    if (result is Failure) {
      _error = result;
      notifyListeners();
      return;
    }

    _storageService.saveToken("");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

  Future deleteUser(BuildContext context) async {
    dynamic result = (await _apiService.deleteUser(_token)).fold(
          (success) => success,
          (failure) => failure,
    );

    if (result is Failure) {
      _error = result;
      notifyListeners();
      return;
    }

    _storageService.saveToken("");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeView(),
      ),
    );
  }

}
