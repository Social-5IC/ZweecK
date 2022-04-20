import 'package:shared_preferences/shared_preferences.dart';
import 'package:zweeck/core/services/storage/storage_service.dart';

class SharedPreferenceService extends StorageService {
  @override
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  @override
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);
  }
}
