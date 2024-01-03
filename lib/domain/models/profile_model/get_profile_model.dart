class GetProfileModel {
  final UserData? data;

  GetProfileModel({required this.data});

  factory GetProfileModel.fromJson(Map<String, dynamic> json) {
    return GetProfileModel(
      data: UserData.fromJson(json['data']),
    );
  }
}

class UserData {
  final User? user;

  UserData({required this.user});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String? id;
  final String? email;
  final String? phoneNumber;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final String? onschedCustomerId;
  final String? coachId;
  final String? handle;
  final String? avatar;
  final String? bio;
  final String? address;
  final String? city;
  final String? state;
  final String? zip;
  final bool? verified;
  final String? username;

  User({
    required this.id,
    required this.email,
    required this.phoneNumber,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.onschedCustomerId,
    required this.coachId,
    required this.handle,
    required this.avatar,
    required this.bio,
    required this.address,
    required this.city,
    required this.state,
    required this.zip,
    required this.verified,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      onschedCustomerId: json['onsched_customer_id'],
      coachId: json['coachId'],
      handle: json['handle'],
      avatar: json['avatar'],
      bio: json['bio'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zip: json['zip'],
      verified: json['verified'],
      username: json['username'],
    );
  }
}
