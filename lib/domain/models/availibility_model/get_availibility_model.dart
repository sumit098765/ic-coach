// class GetAvailibilityModel {
//   final Data? data;

//   GetAvailibilityModel({
//     this.data,
//   });
//   factory GetAvailibilityModel.fromJson(Map<String, dynamic> json) {
//     return GetAvailibilityModel(
//       data: Data.fromJson(json['data']),
//     );
//   }
// }

// class Data {
//   final CoachCalAvailabilityData? coachCalAvailabilityData;

//   Data({this.coachCalAvailabilityData});

//   factory Data.fromJson(Map<String, dynamic> json) {
//     return Data(
//       coachCalAvailabilityData:
//           CoachCalAvailabilityData.fromJson(json['coachCalAvailabilityData']),
//     );
//   }
// }

// class CoachCalAvailabilityData {
//   final WeeklyRanges? weeklyRanges;
//   final Map<String, dynamic>? overRides;

//   CoachCalAvailabilityData({this.weeklyRanges, this.overRides});

//   factory CoachCalAvailabilityData.fromJson(Map<String, dynamic> json) {
//     return CoachCalAvailabilityData(
//       weeklyRanges: WeeklyRanges.fromJson(json['weeklyRanges']),
//       overRides: json['overRides'],
//     );
//   }
// }

// class WeeklyRanges {
//   final Map<String, Day>? days;

//   WeeklyRanges({this.days});

//   factory WeeklyRanges.fromJson(Map<String, dynamic> json) {
//     return WeeklyRanges(
//       days: json.map((key, value) => MapEntry(key, Day.fromJson(value))),
//     );
//   }
// }

// class Day {
//   final Map<String, TimeSlot>? timeSlots;

//   Day({this.timeSlots});

//   factory Day.fromJson(Map<String, dynamic> json) {
//     return Day(
//       timeSlots:
//           json.map((key, value) => MapEntry(key, TimeSlot.fromJson(value))),
//     );
//   }
// }

// class TimeSlot {
//   final int? id;
//   final List<int>? range;

//   TimeSlot({this.id, this.range});

//   factory TimeSlot.fromJson(Map<String, dynamic> json) {
//     return TimeSlot(
//       id: json['id'],
//       range: List<int>.from(json['range'].map((x) => x)),
//     );
//   }
// }

class GetAvailibilityModel {
  final Data? data;

  GetAvailibilityModel({
    this.data,
  });

  factory GetAvailibilityModel.fromJson(Map<String, dynamic> json) {
    return GetAvailibilityModel(
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  final CoachCalAvailabilityData? coachCalAvailabilityData;

  Data({this.coachCalAvailabilityData});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      coachCalAvailabilityData: CoachCalAvailabilityData.fromJson(
        json['coachCalAvailabilityData'],
      ),
    );
  }
}

class CoachCalAvailabilityData {
  final WeeklyRanges? weeklyRanges;
  final Map<String, dynamic>? overRides;
  final Map<String, bool>? availabilities; // New field

  CoachCalAvailabilityData({
    this.weeklyRanges,
    this.overRides,
    this.availabilities,
  });

  factory CoachCalAvailabilityData.fromJson(Map<String, dynamic> json) {
    return CoachCalAvailabilityData(
      weeklyRanges: WeeklyRanges.fromJson(json['weeklyRanges']),
      overRides: json['overRides'],
      availabilities: Map<String, bool>.from(json['availabilities']),
    );
  }
}

class WeeklyRanges {
  final Map<String, Day>? days;

  WeeklyRanges({this.days});

  factory WeeklyRanges.fromJson(Map<String, dynamic> json) {
    return WeeklyRanges(
      days: json.map((key, value) => MapEntry(key, Day.fromJson(value))),
    );
  }
}

class Day {
  final Map<String, TimeSlot>? timeSlots;

  Day({this.timeSlots});

  factory Day.fromJson(Map<String, dynamic> json) {
    return Day(
      timeSlots:
          json.map((key, value) => MapEntry(key, TimeSlot.fromJson(value))),
    );
  }
}

class TimeSlot {
  final int? id;
  final List<int>? range;

  TimeSlot({this.id, this.range});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      range: List<int>.from(json['range'].map((x) => x)),
    );
  }
}
