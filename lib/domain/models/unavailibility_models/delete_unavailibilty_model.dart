class RemoveOnschedAllocationItem {
  final String object;
  final int id;
  final int businessId;
  final int resourceId;
  final String startDate;
  final String endDate;
  final int startTime;
  final int endTime;
  final String reason;
  final bool repeats;
  final dynamic repeat; 
  final bool deletedStatus;
  final String deletedTime;

  RemoveOnschedAllocationItem({
    required this.object,
    required this.id,
    required this.businessId,
    required this.resourceId,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.reason,
    required this.repeats,
    this.repeat,
    required this.deletedStatus,
    required this.deletedTime,
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
      reason: json['reason'],
      repeats: json['repeats'],
      repeat: json['repeat'],
      deletedStatus: json['deletedStatus'],
      deletedTime: json['deletedTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'object': object,
      'id': id,
      'businessId': businessId,
      'resourceId': resourceId,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'reason': reason,
      'repeats': repeats,
      'repeat': repeat,
      'deletedStatus': deletedStatus,
      'deletedTime': deletedTime,
    };
  }
}
