class ForgetPasswordErrorModel {
  final bool? err;
  final String? message;
  final int? statusCode;

  ForgetPasswordErrorModel({required this.err, required this.message, required this.statusCode});

  factory ForgetPasswordErrorModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordErrorModel(
      err: json['err'],
      message: json['message'],
      statusCode: json['statusCode'],
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
