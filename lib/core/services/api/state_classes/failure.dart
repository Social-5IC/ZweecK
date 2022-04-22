class Failure {
  final String timestamp;
  final int error;
  final String message;

  Failure.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"],
        error = json["error"],
        message = json["message"];
}
