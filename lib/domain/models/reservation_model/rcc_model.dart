class RccErrorModel {
  final bool err;
  final String message;
  final int statusCode;

  RccErrorModel({
    required this.err,
    required this.message,
    required this.statusCode,
  });

  factory RccErrorModel.fromJson(Map<String, dynamic> json) {
    return RccErrorModel(
      err: json['err'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'err': err,
      'message': message,
      'statusCode': statusCode,
    };
  }
}
