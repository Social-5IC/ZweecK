class Failure {
  final int statusCode;
  final String timestamp;
  final int code;
  final String message;

  Failure.fromJson(Map<String, dynamic> json)
      : statusCode = json["statusCode"] ?? 0,
        timestamp = json["timestamp"] ?? DateTime.now().toString(),
        code = json["error"] ?? 0,
        message = json["message"] ?? "";
}
