

class ReservationPackageModel {
  final ReservationData data;

  ReservationPackageModel({
    required this.data,
  });

  factory ReservationPackageModel.fromJson(Map<String, dynamic> json) {
  // log("Time List ${json['data']}");
    return ReservationPackageModel(
        data: ReservationData.fromJson(json['data']));
  }
}

class ReservationData {
  final List<ReservationTime> reservationTimes;

  ReservationData({
    required this.reservationTimes,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> timesList = json['reservationTimes'];
  
    final List<ReservationTime> reservationTimes =
        timesList.map((time) => ReservationTime.fromJson(time)).toList();

    return ReservationData(reservationTimes: reservationTimes);
  }
}

class ReservationTime {
  final String? reservationTimeId;
  final String? reservationId;
  final dynamic scheduledStart;
  final dynamic scheduledEnd;
  final String? status;
  final dynamic onSchedAppointmentId;
  final dynamic notes;
  final dynamic operationsStatus;
  final bool? deleted;
  final String? createdAt;
  final String? updatedAt;
  final dynamic timezoneName;
  final dynamic location;
  final dynamic joinUrl;
  final dynamic startUrl;
  final String? emailReminder;
  final bool? reqRescheduleStatus;
  final bool? reqCancelStatus;
  final bool? reqConfirmStatus;

  ReservationTime({
    this.reservationTimeId,
    this.reservationId,
    this.scheduledStart,
    this.scheduledEnd,
    this.status,
    this.onSchedAppointmentId,
    this.notes,
    this.operationsStatus,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.timezoneName,
    this.location,
    this.joinUrl,
    this.startUrl,
    this.emailReminder,
    this.reqRescheduleStatus,
    this.reqCancelStatus,
    this.reqConfirmStatus,
  });

  factory ReservationTime.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return ReservationTime();
    }
    return ReservationTime(
      reservationTimeId: json['reservation_time_id'] ?? '',
      reservationId: json['reservation_id'] ?? '',
      scheduledStart: json['scheduled_start'],
      scheduledEnd: json['scheduled_end'],
      status: json['status'] ?? '',
      onSchedAppointmentId: json['onsched_appointment_id'],
      notes: json['notes'],
      operationsStatus: json['operations_status'],
      deleted: json['deleted'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      timezoneName: json['timezone_name'],
      location: json['location'],
      joinUrl: json['join_url'],
      startUrl: json['start_url'],
      emailReminder: json['email_reminder'] ?? '',
      reqRescheduleStatus: json['req_reschedule_status'] ?? false,
      reqCancelStatus: json['req_cancel_status'] ?? false,
      reqConfirmStatus: json['req_confirm_status'] ?? false,
    );
  }
}
