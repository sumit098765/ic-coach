class ResetPasswordModel {
  final Data? data;
  final ErrorResponseModel? errorResponse;

  ResetPasswordModel({
    this.data,
    this.errorResponse,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      return ResetPasswordModel(data: Data.fromJson(json['data']));
    } else {
      return ResetPasswordModel(
          errorResponse: ErrorResponseModel.fromJson(json));
    }
  }
}

class Data {
  final bool? success;

  Data({required this.success});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(success: json['success'] as bool? ?? false);
  }
}

class ErrorResponseModel {
  final bool? err;
  final String? message;
  final int? statusCode;

  ErrorResponseModel({
    required this.err,
    required this.message,
    required this.statusCode,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    return ErrorResponseModel(
      err: json['err'] as bool? ?? false,
      message: json['message'] as String? ?? "",
      statusCode: json['statusCode'] as int? ?? 0,
    );
  }
}
