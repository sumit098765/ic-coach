
class LoginModel {
  UserData? data;
  ErrorResponse? errorResponse;

  LoginModel({
    this.data,
    this.errorResponse,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('err')) {
      return LoginModel(
        errorResponse: ErrorResponse.fromJson({
          'err': json['err'],
          'message': json['message'],
          'statusCode': json['statusCode'],
        }),
      );
    } else {
      return LoginModel(
        data: UserData.fromJson(json['data']),
      );
    }
  }
}

class ErrorResponse {
  bool err;
  String message;
  int statusCode;

  ErrorResponse({
    required this.err,
    required this.message,
    required this.statusCode,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      err: json['err'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
    );
  }

  factory ErrorResponse.fromString(String errorMessage) {
    return ErrorResponse(
      err: true,
      message: errorMessage,
      statusCode: 0,
    );
  }
}

class UserData {
  User user;
  String token;

  UserData({required this.user, required this.token});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
      token: json['token'] ?? "",
    );
  }
}

class User {
  String id;
  String email;
  String name;
  String createdAt;
  String updatedAt;
  String avatar;
  String bio;
  bool verified;
  String username;
  String coachId;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.avatar,
    required this.bio,
    required this.verified,
    required this.username,
    required this.coachId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? "",
      email: json['email'] ?? "",
      name: json['name'] ?? "",
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      avatar: json['avatar'] ?? "",
      bio: json['bio'] ?? "",
      verified: json['verified'] ?? false,
      username: json['username'] ?? "",
      coachId: json['coach_id'] ?? "",
    );
  }
}

class Claims {
  String email;
  String id;
  String authProviderId;
  bool verified;
  String userType;
  String username;
  String coachId;
  int iat;
  int exp;
  String iss;

  Claims({
    required this.email,
    required this.id,
    required this.authProviderId,
    required this.verified,
    required this.userType,
    required this.username,
    required this.coachId,
    required this.iat,
    required this.exp,
    required this.iss,
  });

  factory Claims.fromJson(Map<String, dynamic> json) {
    return Claims(
      email: json['email'] ?? "",
      id: json['id'] ?? "",
      authProviderId: json['authProviderId'] ?? "",
      verified: json['verified'] ?? false,
      userType: json['user_type'] ?? "",
      username: json['username'] ?? "",
      coachId: json['coach_id'] ?? "",
      iat: json['iat'] ?? 0,
      exp: json['exp'] ?? 0,
      iss: json['iss'] ?? "",
    );
  }
}
