class Failure {
  final String timestamp;
  final int code;
  final String message;

  Failure.fromJson(Map<String, dynamic> json)
      : timestamp = json["timestamp"],
        code = json["error"],
        message = json["message"];
}
