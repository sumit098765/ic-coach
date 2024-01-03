class CreateOverrideModel {
  final Data? data;

  CreateOverrideModel({this.data});

  CreateOverrideModel.fromJson(Map<String, dynamic> json)
      : data = json['data'] != null ? Data.fromJson(json['data']) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final String? object;
  final int? id;
  final int? businessId;
  final int? resourceId;
  final String? startDate;
  final String? endDate;
  final int? startTime;
  final int? endTime;
  final String? reason;
  final bool? repeats;
  final bool? deletedStatus;
  final String? deletedTime;
  final Schedule? schedule; // Add this field

  Data({
    this.object,
    this.id,
    this.businessId,
    this.resourceId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.reason,
    this.repeats,
    this.deletedStatus,
    this.deletedTime,
    this.schedule, // Include this in the constructor
  });

  Data.fromJson(Map<String, dynamic> json)
      : object = json['object'],
        id = json['id'],
        businessId = json['businessId'],
        resourceId = json['resourceId'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        startTime = json['startTime'],
        endTime = json['endTime'],
        reason = json['reason'],
        repeats = json['repeats'],
        deletedStatus = json['deletedStatus'],
        deletedTime = json['deletedTime'],
        schedule = json['schedule'] != null
            ? Schedule.fromJson(json['schedule'])
            : null; // Deserialize 'schedule' field

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    data['id'] = id;
    data['businessId'] = businessId;
    data['resourceId'] = resourceId;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['reason'] = reason;
    data['repeats'] = repeats;
    data['deletedStatus'] = deletedStatus;
    data['deletedTime'] = deletedTime;
    if (schedule != null) {
      data['schedule'] = schedule!.toJson(); // Serialize 'schedule' field
    }
    return data;
  }
}

class Schedule {
  String id;
  String date;
  int onschedId;
  int onschedResourceId;
  String type;
  int startTime;
  int endTime;
  DateTime createdAt;
  DateTime updatedAt;
  String status;

  Schedule({
    required this.id,
    required this.date,
    required this.onschedId,
    required this.onschedResourceId,
    required this.type,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      date: json['date'],
      onschedId: json['onsched_id'],
      onschedResourceId: json['onsched_resource_id'],
      type: json['type'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'onsched_id': onschedId,
      'onsched_resource_id': onschedResourceId,
      'type': type,
      'start_time': startTime,
      'end_time': endTime,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'status': status,
    };
  }
}
