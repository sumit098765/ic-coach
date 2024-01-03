import 'dart:developer';

class ApiUrls {
  static const String servicesBaseUrl =
      "https://identity-service-qa-lmcr6wscfq-uc.a.run.app";
  static const String identityBaseUrl =
      "https://api-service-qa-lmcr6wscfq-uc.a.run.app";

  // static const String servicesBaseUrl = "http://172.28.224.1:7201";
  // static const String identityBaseUrl = "http://172.28.224.1:7002";

  static const String rccRequest =
      "$identityBaseUrl/reservations/appointment/request-status";
  static String allReservation(
    String coachId,
    int pageNumber,
  ) {
    return "$identityBaseUrl/reservations/coach/$coachId?perPage=7&page=$pageNumber&category=scheduled";
  }

  static String getReservationById(String reservationId) {
    //log("reservation type ::::::::::$reserType");
    return "$identityBaseUrl/reservations/$reservationId";
  }

  static String getReservationByPackage(String reservationId) {
    return "$identityBaseUrl/reservations/$reservationId/reservation-times";
  }

  static const String googleLogin =
      "$servicesBaseUrl/users/authenticate/google";
  static const String login = "$servicesBaseUrl/users/authenticate";

  static String createAvailibility(String coachID) {
    return "$identityBaseUrl/coaches/$coachID/calendar/create-allocations";
  }

  static String getAvailibility(String coachID) {
    return "$identityBaseUrl/coaches/$coachID/calendar/list-allocations-overrides";
  }

  static String deleteAvailibility(int allocationId) {
    log("Inside URLS $allocationId");
    return "$identityBaseUrl/coaches/onsched/remove-allocation-time/$allocationId";
  }

  static String createUnAvailibility(String coachID) {
    return "$identityBaseUrl/coaches/$coachID/onsched/date-overrides";
  }

  static String getUnAvailibility(String coachID, selectedDate) {
    return "$identityBaseUrl/coaches/$coachID/onsched/date-overrides/$selectedDate";
  }

  static String deleteUnAvailibility(String coachId, String date, int id) {
    return "$identityBaseUrl/coaches/$coachId/onsched/date-overrides/$date/$id";
  }

  static String updateFCMTokens(String coachId) {
    return "$identityBaseUrl/coaches/$coachId/fcm-tokens";
  }

  static String deleteFCMTokens(String coachId) {
    return "$identityBaseUrl/coaches/$coachId/fcm-tokens";
  }

  static String getCoachNotifications(String coachId) {
    return "$identityBaseUrl/notifications/coaches/$coachId/data";
  }

  static String getCoachUnseenNotificationCount(String coachId) {
    return "$identityBaseUrl/notifications/coaches/$coachId/count";
  }

  static const String getProfileUrl = "$servicesBaseUrl/users/me";

  static String editProfileUrl(String id) {
    return "$identityBaseUrl/users/$id";
  }

  static String uploadPPUrl(String id) {
    return "$identityBaseUrl/upload/avatar/$id";
  }


 static const String forgetPassUrl=
      "$servicesBaseUrl/users/request-password-reset";

 static const String resetPassUrl=
      "$servicesBaseUrl/users/update-old-password";

}
