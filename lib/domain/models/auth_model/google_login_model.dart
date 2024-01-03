class GoogleLoginModel {
  final User user;
  final String token;
  final Claims claims;
  final ErrorResponse? errorResponse; // Include ErrorResponse as an optional property

  GoogleLoginModel({
    required this.user,
    required this.token,
    required this.claims,
    this.errorResponse, // Make ErrorResponse optional in the constructor
  });

  factory GoogleLoginModel.fromJson(Map<String, dynamic> json) {
    // Check if there is an 'error' field in the JSON
    ErrorResponse? errorResponse;
    if (json['error'] != null) {
      errorResponse = ErrorResponse.fromJson(json['error']);
    }

    return GoogleLoginModel(
      user: User.fromJson(json['data']['user']),
      token: json['data']['token'],
      claims: Claims.fromJson(json['data']['claims']),
      errorResponse: errorResponse,
    );
  }
}

class User {
  final String id;
  final String email;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String coachId;
  final String? avatar;
  final String? bio;
  final String credentialType;
  final String authProviderId;
  final bool verified;
  final String username;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.coachId,
    this.avatar,
    this.bio,
    required this.credentialType,
    required this.authProviderId,
    required this.verified,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      coachId: json['coachId'] ?? "",
      avatar: json['avatar'],
      bio: json['bio'],
      credentialType: json['credentialType'] ?? "",
      authProviderId: json['authProviderId'] ?? "",
      verified: json['verified'] ?? false,
      username: json['username'],
    );
  }
}

class Claims {
  final String email;
  final String id;
  final String authProviderId;
  final bool verified;
  final String userType;
  final String username;
  final String coachId;
  final int iat;
  final int exp;
  final String iss;

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

class ErrorResponse {
  bool err;
  String message;
  int statusCode;

  ErrorResponse({required this.err, required this.message, required this.statusCode});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
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
