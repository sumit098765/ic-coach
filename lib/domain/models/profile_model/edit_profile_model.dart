class EditProfileModel {
  final UserData data;

  EditProfileModel({required this.data});

  factory EditProfileModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception("Cannot create EditProfileModel from null JSON");
    }
    return EditProfileModel(
      data: UserData.fromJson(json['data'] as Map<String, dynamic>?),
    );
  }
}

class UserData {
  final User user;

  UserData({required this.user});

  factory UserData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception("Cannot create UserData from null JSON");
    }
    return UserData(
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? stripeCustomerId;
  final String? avatar;
  final String? bio;
  final String? onschedCustomerId;
  final bool? verified;
  final bool? deleted;
  final String? createdAt;
  final String? updatedAt;
  final String? userType;
  final String? username;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.stripeCustomerId,
    required this.avatar,
    required this.bio,
    required this.onschedCustomerId,
    required this.verified,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.userType,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception("Cannot create User from null JSON");
    }
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      stripeCustomerId: json['stripe_customer_id'] ?? "",
      avatar: json['avatar'] ?? '',
      bio: json['bio'] ?? '',
      onschedCustomerId: json['onsched_customer_id'] ?? "",
      verified: json['verified'] ?? false,
      deleted: json['deleted'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      userType: json['user_type'] ?? '',
      username: json['username'] ?? '',
    );
  }
}
