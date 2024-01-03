class GetNotifyCountModel {
  DataModel data;

  GetNotifyCountModel({required this.data});

  factory GetNotifyCountModel.fromJson(Map<String, dynamic> json) {
    return GetNotifyCountModel(
      data: DataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class DataModel {
  String count;

  DataModel({required this.count});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
    };
  }
}
