abstract class StorageService {
  // retrieve the session token from local storage
  Future<String> getToken();

  // save the session token in the local storage
  Future<void> saveToken(String token);
}
