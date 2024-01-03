class UploadProfilePictureModel {
  final String message;
  final String url;

  UploadProfilePictureModel({required this.message, required this.url});

  factory UploadProfilePictureModel.fromJson(Map<String, dynamic> json) {
    return UploadProfilePictureModel(
      message: json['data']['message'] ?? '',
      url: json['data']['url'] ?? '',
    );
  }
}
