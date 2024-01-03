import 'dart:developer';

class DeleteAvailibilityModel {
  final Data? data;

  DeleteAvailibilityModel({this.data});

  factory DeleteAvailibilityModel.fromJson(Map<String, dynamic> json) {
    log("Reason ${json['data']}");
    return DeleteAvailibilityModel(
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  final RemoveOnschedAllocationItem? removeOnschedAllocationItem;

  Data({this.removeOnschedAllocationItem});

  factory Data.fromJson(Map<String, dynamic> json) {
    
    return Data(
      removeOnschedAllocationItem: json['removeOnschedAllocationItem'] != null
          ? RemoveOnschedAllocationItem.fromJson(
              json['removeOnschedAllocationItem'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (removeOnschedAllocationItem != null) {
      data['removeOnschedAllocationItem'] =
          removeOnschedAllocationItem!.toJson();
    }
    return data;
  }
}

class RemoveOnschedAllocationItem {
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
  final Repeat? repeat;
  final bool? deletedStatus;
  final String? deletedTime;

  RemoveOnschedAllocationItem({
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
    this.repeat,
    this.deletedStatus,
    this.deletedTime,
  });

  factory RemoveOnschedAllocationItem.fromJson(Map<String, dynamic> json) {
    return RemoveOnschedAllocationItem(
      object: json['object'],
      id: json['id'],
      businessId: json['businessId'],
      resourceId: json['resourceId'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      reason: json['reason'] ?? "",
      repeats: json['repeats'],
      repeat: json['repeat'] != null ? Repeat.fromJson(json['repeat']) : null,
      deletedStatus: json['deletedStatus'],
      deletedTime: json['deletedTime'],
    );
  }

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
    if (repeat != null) {
      data['repeat'] = repeat!.toJson();
    }
    data['deletedStatus'] = deletedStatus;
    data['deletedTime'] = deletedTime;
    return data;
  }
}

class Repeat {
  final String? frequency;
  final int? interval;
  final String? weekdays;
  final String? monthDay;
  final String? monthType;

  Repeat({
    this.frequency,
    this.interval,
    this.weekdays,
    this.monthDay,
    this.monthType,
  });

  factory Repeat.fromJson(Map<String, dynamic> json) {
    return Repeat(
      frequency: json['frequency'],
      interval: json['interval'],
      weekdays: json['weekdays'],
      monthDay: json['monthDay'],
      monthType: json['monthType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['frequency'] = frequency;
    data['interval'] = interval;
    data['weekdays'] = weekdays;
    data['monthDay'] = monthDay;
    data['monthType'] = monthType;
    return data;
  }
}
