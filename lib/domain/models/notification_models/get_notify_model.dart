class GetNotifyModel {
  DataModel data;

  GetNotifyModel({required this.data});

  factory GetNotifyModel.fromJson(Map<String, dynamic> json) {
    return GetNotifyModel(
      data: DataModel.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
    };
  }
}

class Notification {
  String id;
  String coachId;
  String reservationId;
  dynamic reservationTimesId;
  String title;
  String body;
  String createdAt;
  String updatedAt;
  String status;

  Notification({
    required this.id,
    required this.coachId,
    required this.reservationId,
    this.reservationTimesId,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      coachId: json['coach_id'],
      reservationId: json['reservation_id'],
      reservationTimesId: json['reservation_times_id'],
      title: json['title'],
      body: json['body'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'coach_id': coachId,
      'reservation_id': reservationId,
      'reservation_times_id': reservationTimesId,
      'title': title,
      'body': body,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
    };
  }
}

class DataModel {
  List<Notification> notifications;
  String count;

  DataModel({required this.notifications, required this.count});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      notifications: (json['notifications'] as List)
          .map((i) => Notification.fromJson(i))
          .toList(),
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notifications': notifications.map((i) => i.toJson()).toList(),
      'count': count,
    };
  }
}
