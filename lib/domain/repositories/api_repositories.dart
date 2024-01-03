import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:instacoach/data/api_response.dart';

import 'package:instacoach/domain/models/reservation_model/get_all_reservation_model.dart';
import 'package:instacoach/utils/constants/api_urls.dart';

import '../models/auth_model/forget_password_error_model.dart';
import '../models/auth_model/google_login_model.dart';
import '../models/auth_model/login_model.dart';

import '../models/auth_model/reset_password_model.dart';
import '../models/availibility_model/availibility_model.dart';
import '../models/availibility_model/delete_availibility_model.dart';
import '../models/availibility_model/get_availibility_model.dart';
import '../models/notification_models/get_notify_count_model.dart';
import '../models/notification_models/get_notify_model.dart';
import '../models/profile_model/edit_profile_model.dart';
import '../models/profile_model/get_profile_model.dart';
import '../models/profile_model/upload_profile_model.dart';
import '../models/reservation_model/filter_model.dart';
import '../models/reservation_model/get_single_package_model.dart';
import '../models/reservation_model/get_single_reservation_model.dart';
import '../models/reservation_model/rcc_model.dart';
import '../models/unavailibility_models/create_unavailibility_model.dart';
import '../models/unavailibility_models/get_unavailibility_model.dart';

// class HeaderProvider {
//   final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

//   Future<Map<String, String>> getHeaders() async {
//     final token = await secureStorage.read(key: "token");

//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       if (token != null) "Authorization": "Bearer $token",
//     };

//     return headers;
//   }
// }

// class ApiService<T> {
//   final HeaderProvider headerProvider;
//   final returnType;
//   ApiService(this.headerProvider, this.returnType);

//   Future<T> fetchData(String url, {List<T>? params}) async {
//     final headers = await headerProvider.getHeaders();

//     final response = await http.get(Uri.parse(url), headers: headers);

//     if (response.statusCode == 200) {
//       return returnType;
//       //return json.decode(response.body) as T;
//     } else {
//       throw Exception();
//     }
//   }
// }

// class Main {
//   final apiService =
//       ApiService<Map<String, dynamic>>(HeaderProvider(), ApiResponse());
//   apiServices() async {
//     final data = await apiService.fetchData("url");
//     return ApiResponse(data: data);
//   }
// }

class ApiServices {
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Map<String, String> header = {'Content-Type': 'application/json'};

  Future<Map<String, String>> getHeaders() async {
    final token = await secureStorage.read(key: "token");

    Map<String, String> header = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    return header;
  }

// Get All Reservation
  Future<ApiResponse<GetAllReservationModel>> getAllReservationRespository(
      String coachId, int pageNumber) async {
    //log("CID  in repo $coachId");
    final url = Uri.parse(ApiUrls.allReservation(coachId, pageNumber));
    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    //log("Response ::: ${response.body}");
    log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("jsonResponse ${jsonResponse}");
      final deResponse = GetAllReservationModel.fromJson(jsonResponse);
      log("jsonResponse ${deResponse.data}");
      return ApiResponse<GetAllReservationModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<GetAllReservationModel>(
        error: true, errorMessage: error, responseCode: response.statusCode);
  }

// get single reservation Single
  Future<ApiResponse<GetSingleReservationModel>>
      getSingleReservationRespository(String reserId) async {
    final url = Uri.parse(ApiUrls.getReservationById(reserId));
    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    // log("Response ::: ${response.body}");
    // log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("jsonResponse ${jsonResponse}");
      final deResponse = GetSingleReservationModel.fromJson(jsonResponse);

      //log("DeResponse of reservation data ${deResponse.combinedReservation}");
      // Check if reservation times is not null before logging

      return ApiResponse<GetSingleReservationModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<GetSingleReservationModel>(
      error: true,
      errorMessage: error,
      responseCode: response.statusCode,
    );
  }

  // get single reservation Packages
  Future<ApiResponse<ReservationPackageModel>>
      getSinglePackageReservationRespository(String reserId) async {
    try {
      final url = Uri.parse(ApiUrls.getReservationByPackage(reserId));
      final headers = await getHeaders();
      final response = await http.get(
        url,
        headers: headers,
      );

      // log("Response  ::: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        //log("jsonResponse: $jsonResponse");

        final deResponse = ReservationPackageModel.fromJson(jsonResponse);
        // log("DeResponse : $deResponse");

        return ApiResponse(data: deResponse);
      } else {
        final error = jsonDecode(response.body);
        // log("Error: $error");
        return ApiResponse<ReservationPackageModel>(
          error: true,
          errorMessage: error,
          responseCode: response.statusCode,
        );
      }
    } catch (e) {
      //log("Exception: $e\n$stackTrace");
      return ApiResponse<ReservationPackageModel>(
        error: true,
        errorMessage: 'Exception occurred',
      );
    }
  }

// Login API

  Future<ApiResponse<LoginModel>> loginRepository(
    String email,
    String password,
  ) async {
    final url = Uri.parse(ApiUrls.login);
    // final headers = await getHeaders();
    final jsonBody = jsonEncode({"email": email, "password": password});
    //log("email $email");

    final response = await http.post(
      url,
      headers: {
        "x-coach-panel": 'true',
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    //  log("Response ::: ${response.body}");
    //log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //log("jsonResponse ${jsonResponse}");
      final deResponse = LoginModel.fromJson(jsonResponse);
      //log("jsonResponse ${deResponse}");
      if (deResponse.data!.user.verified == true) {
        await secureStorage.write(key: "token", value: deResponse.data!.token);
        await secureStorage.write(
            key: "coachId", value: deResponse.data!.user.coachId);
      }
      return ApiResponse<LoginModel>(data: deResponse);
    }

    final error = jsonDecode(response.body);
    final data = LoginModel.fromJson(error);
    //log("Error in login $data");
    return ApiResponse<LoginModel>(data: data);
  }

// filter

  Future<ApiResponse<FilterModel>> filterRespository(
      String coachId, String param, int page) async {
    // log("param :::::$param");
    // log("pages $page");
    final url = Uri.parse(
        "https://api-service-qa-lmcr6wscfq-uc.a.run.app/reservations/coach/$coachId?perPage=7&page=$page&category=$param");
    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    // log("Response ::: ${response.body}");
    // log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //log("jsonResponse ${jsonResponse}");
      final deResponse = FilterModel.fromJson(jsonResponse);
      // log("Filter  DeResponse ::::::::$deResponse");
      return ApiResponse<FilterModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<FilterModel>(
        error: true, errorMessage: error, responseCode: response.statusCode);
  }

// Google Login API

  Future<ApiResponse<GoogleLoginModel>> gooleloginRepository(
      String clientId, String idToken, String referralId) async {
    // log("clientId $clientId............  idToken $idToken........... referralId $referralId ");
    final url = Uri.parse(ApiUrls.googleLogin);
    // final headers = await getHeaders();
    final jsonBody = jsonEncode({
      "client_id": clientId,
      "credential": idToken,
      "referralId": referralId
    });
    //log("email $email");

    final response = await http.post(
      url,
      headers: {
        "x-coach-panel": 'true',
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );
    //log("Response ::: ${response.body}");
    //log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("jsonResponse ${jsonResponse}");
      final deResponse = GoogleLoginModel.fromJson(jsonResponse);
      //  log("jsonResponse ${deResponse}");
      if (deResponse.user.verified == true) {
        await secureStorage.write(key: "token", value: deResponse.token);
      }
      return ApiResponse<GoogleLoginModel>(data: deResponse);
    }

    final error = jsonDecode(response.body);
    final data = GoogleLoginModel.fromJson(error);
    //log("Error in login $data");
    return ApiResponse<GoogleLoginModel>(data: data);
  }

//RCC Repo
  Future<ApiResponse> rccRequestRepository(String coachId, String reserId,
      String requestType, String reserType) async {
    //log("RCC Type $reserType");
    // log("RCC TIME ID $reserId");
    final url = Uri.parse(ApiUrls.rccRequest);
    final headers = await getHeaders();
    final jsonBody = reserType == "package"
        ? jsonEncode({
            "coachId": coachId,
            "reservationTimeId": reserId,
            "requestType": requestType,
          })
        : jsonEncode({
            "coachId": coachId,
            "reservationId": reserId,
            "requestType": requestType,
          });
    // log("coachId $coachId");
    // log("res ID ::::::::::::$reserId");
    final response = await http.put(
      url,
      headers: headers,
      body: jsonBody,
    );
    //log("Response ::: ${response.body}");
    //log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      //  final jsonResponse = jsonDecode(response.body);
      // log("jsonResponse ${jsonResponse}");
      // final deResponse = LoginModel.fromJson(jsonResponse);
      //log("jsonResponse ${deResponse}");
      log("Response . body ${response.body}");
      return ApiResponse(data: response.body);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      final data = RccErrorModel.fromJson(error);
      log("Error in RCC REPO $error");
      return ApiResponse(data: data);
    }

    //log("Error in login $data");
    return ApiResponse(data: response.body);
  }

  // Availibility Repo

  Future<ApiResponse<AvailibilityModel>> availibilityRepository(String coachId,
      String startDate, String day, String startTime, String endTime) async {
    // log("Start Time ${startTime}");
    // log("End Time ${endTime}");
    // log("Days ${day}");
    // log("Start Date ${startDate}");
    final url = Uri.parse(ApiUrls.createAvailibility(coachId));
    final headers = await getHeaders();
    final jsonBody = jsonEncode({
      "startDate": startDate, //"2023-11-26",
      "weeklyRanges": {
        day: {
          "ranges": [
            [startTime, endTime],
          ]
        },
      }
    });

    final response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    // log("Response ::: ${response.body}");
    // log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("jsonResponse ${jsonResponse}");
      final deResponse = AvailibilityModel.fromJson(jsonResponse);
      //log("jsonResponse ${deResponse}");

      return ApiResponse<AvailibilityModel>(data: deResponse);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      final data = AvailibilityModel.fromJson(error);
      //  log("Error in availibilty REPO $error");
      return ApiResponse<AvailibilityModel>(data: data);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<AvailibilityModel>(data: error);
  }

// Get Availibility Repo
  Future<ApiResponse<GetAvailibilityModel>> getAvailibilityRespository(
    String coachId,
  ) async {
    final url = Uri.parse(ApiUrls.getAvailibility(coachId));
    // log("CoachID $coachId");
    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    // log("Response ::: ${response.body}");
    //log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //log("jsonResponse ${jsonResponse}");
      final deResponse = GetAvailibilityModel.fromJson(jsonResponse);
      // log("Filter  DeResponse ::::::::$deResponse");
      return ApiResponse<GetAvailibilityModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<GetAvailibilityModel>(
        error: true, errorMessage: error, responseCode: response.statusCode);
  }

  //Delete Availibility Repo

  Future<ApiResponse<DeleteAvailibilityModel>> deleteAvailibilityRepository(
      int allocationId) async {
    //  log("allocationId $allocationId");

    final url = Uri.parse(ApiUrls.deleteAvailibility(allocationId));
    final headers = await getHeaders();

    final response = await http.delete(
      url,
      headers: headers,
    );
    //log("Response ::: ${response.body}");
    // log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //log("jsonResponse ${jsonResponse}");
      final deResponse = DeleteAvailibilityModel.fromJson(jsonResponse);
      // log("jsonResponse ${deResponse}");

      return ApiResponse<DeleteAvailibilityModel>(data: deResponse);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      //log("Error response $error");
      final data = DeleteAvailibilityModel.fromJson(error);
      // log("Error DeResponse $error");
      return ApiResponse<DeleteAvailibilityModel>(data: data);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<DeleteAvailibilityModel>(data: error);
  }

  // Create Unavailibility Repo

  Future<ApiResponse<CreateOverrideModel>> unAvailibilityRepository(
      String coachId,
      String selectedDate,
      int startTime,
      int endTime,
      bool blocWholeDay) async {
    //  log("Start Time ${selectedDate}");
    // log("Start Time ${startTime}");
    // log("Start Time ${endTime}");
    // log("Is Blocked or not $blocWholeDay");
    final url = Uri.parse(ApiUrls.createUnAvailibility(coachId));
    final headers = await getHeaders();
    final jsonBody = jsonEncode({
      "date": selectedDate,
      "startTime": startTime,
      "endTime": endTime,
      "blockFullDay": blocWholeDay
    });

    final response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    //log("Response ::: ${response.body}");
    // log("Status in create override :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("create Override jsonResponse ${jsonResponse}");
      final deResponse = CreateOverrideModel.fromJson(jsonResponse);
      // log("create Override DEResponse ${deResponse}");

      return ApiResponse<CreateOverrideModel>(data: deResponse);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      final data = CreateOverrideModel.fromJson(error);
      //log("Error in availibilty REPO $error");
      return ApiResponse<CreateOverrideModel>(data: data);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<CreateOverrideModel>(data: error);
  }

  // Get UNAvailibility Repo
  Future<ApiResponse<GetOverrideModel>> getUnAvailibilityRespository(
      String coachId, String selectedDate) async {
    final url = Uri.parse(ApiUrls.getUnAvailibility(coachId, selectedDate));
    // log("CoachID $coachId");
    //log(selectedDate);
    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    // log("Response ::: ${response.body}");
    // log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("Get override  jsonResponse ${jsonResponse}");
      final deResponse = GetOverrideModel.fromJson(jsonResponse);
      //   log("Get override  DeResponse ::::::::$deResponse");
      return ApiResponse<GetOverrideModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<GetOverrideModel>(
        error: true, errorMessage: error, responseCode: response.statusCode);
  }

  //Delete UnAvailibility Repo

  Future<ApiResponse<DeleteAvailibilityModel>> deleteUnAvailibilityRepository(
      String coachId, String selectedDate, int id, bool isUnBlocked) async {
    // log("selectedDate $selectedDate");
    // log("Id $id");
    // log("IS UNBLOCKED $isUnBlocked");

    final url =
        Uri.parse(ApiUrls.deleteUnAvailibility(coachId, selectedDate, id));
    final headers = await getHeaders();

    final response = await http.delete(url,
        headers: headers, body: jsonEncode({"unblockFullDay": isUnBlocked}));
    //log("Response ::: ${response.body}");
    //log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //log("jsonResponse ${jsonResponse}");
      final deResponse = DeleteAvailibilityModel.fromJson(jsonResponse);
      // log("jsonResponse ${deResponse.data!.removeOnschedAllocationItem!.reason}");

      return ApiResponse<DeleteAvailibilityModel>(data: deResponse);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      // log("Error response $error");
      final data = DeleteAvailibilityModel.fromJson(error);
      //log("Error DeResponse $error");
      return ApiResponse<DeleteAvailibilityModel>(data: data);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<DeleteAvailibilityModel>(data: error);
  }

  //Update FCM Tokens API
  Future<ApiResponse> updateFCMTokensRepository(
      String coachId, String token) async {
    final url = Uri.parse(ApiUrls.updateFCMTokens(coachId));
    final headers = await getHeaders();
    final jsonBody = jsonEncode({
      "token": token,
    });

    final response = await http.put(
      url,
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return ApiResponse(data: jsonResponse);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      return ApiResponse(data: error);
    }
    final error = jsonDecode(response.body);
    return ApiResponse(data: error);
  }

  // // Get All Coach Notifications Repo
  // Future<ApiResponse<GetNotifyModel>> getCoachNotificationsRespository(String coachId) async {
  //   final url = Uri.parse(ApiUrls.getCoachNotifications(coachId));
  //   final headers = await getHeaders();
  //   final response = await http.get(
  //     url,
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     return ApiResponse(data: jsonResponse);
  //   }
  //   final error = jsonDecode(response.body);
  //   return ApiResponse(
  //       error: true, errorMessage: error, responseCode: response.statusCode);
  // }

  //Delete FCM Tokens API
  Future<ApiResponse> deleteFCMTokensRepository(
      String coachId, String token) async {
    final url = Uri.parse(ApiUrls.deleteFCMTokens(coachId));
    final headers = await getHeaders();
    final jsonBody = jsonEncode({
      "token": token,
    });

    final response = await http.delete(
      url,
      headers: headers,
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      log("FCM token $jsonResponse");
      return ApiResponse(data: jsonResponse);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      return ApiResponse(data: error);
    }
    final error = jsonDecode(response.body);
    return ApiResponse(data: error);
  }

  // Get All Coach Notifications Repo
  Future<ApiResponse<GetNotifyModel>> getCoachNotificationsRespository(
    String coachId,
  ) async {
    final url = Uri.parse(ApiUrls.getCoachNotifications(coachId));
    //log("CoachID $coachId");

    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    //log("Response ::: ${response.body}");
    //log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("Get override  jsonResponse ${jsonResponse}");
      final deResponse = GetNotifyModel.fromJson(jsonResponse);
      //log("Get override  DeResponse ::::::::$deResponse");
      return ApiResponse<GetNotifyModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<GetNotifyModel>(
        error: true, errorMessage: error, responseCode: response.statusCode);
  }

  // // Get All Coach Unseen Notifications Count Repo
  // Future<ApiResponse> getCoachUnseenNotificationsCountRespository(
  //     String coachId) async {
  //   final url = Uri.parse(ApiUrls.getCoachUnseenNotificationCount(coachId));
  //   final headers = await getHeaders();
  //   final response = await http.get(
  //     url,
  //     headers: headers,
  //   );

  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     return ApiResponse(data: jsonResponse);
  //   }
  //   final error = jsonDecode(response.body);
  //   return ApiResponse(
  //       error: true, errorMessage: error, responseCode: response.statusCode);
  // }

  // Get All Coach Unseen Notifications Count Repo
  Future<ApiResponse<GetNotifyCountModel>>
      getCoachUnseenNotificationsCountRespository(
    String coachId,
  ) async {
    final url = Uri.parse(ApiUrls.getCoachUnseenNotificationCount(coachId));
    //  log("CoachID $coachId");

    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    // log("Response ::: ${response.body}");
    //log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      // log("Get override  jsonResponse ${jsonResponse}");
      final deResponse = GetNotifyCountModel.fromJson(jsonResponse);
      //log("Get override  DeResponse ::::::::$deResponse");
      return ApiResponse<GetNotifyCountModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<GetNotifyCountModel>(
        error: true, errorMessage: error, responseCode: response.statusCode);
  }

  // Get Profile Repo
  Future<ApiResponse<GetProfileModel>> getProfileRespository() async {
    final url = Uri.parse(ApiUrls.getProfileUrl);
    // log("CoachID $coachId");
    //log(selectedDate);
    final headers = await getHeaders();
    final response = await http.get(
      url,
      headers: headers,
    );
    // log("Response ::: ${response.body}");
    // log("Status :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //  log("Get override  jsonResponse ${jsonResponse}");
      final deResponse = GetProfileModel.fromJson(jsonResponse);
      // log("Get override  DeResponse ::::::::$deResponse");
      return ApiResponse<GetProfileModel>(data: deResponse);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<GetProfileModel>(
        error: true, errorMessage: error, responseCode: response.statusCode);
  }

//Edit Profile Repo
  Future<ApiResponse<EditProfileModel>> editProfileRepository(
    String userId,
    String name,
    String phoneNumber,
    String address,
  ) async {
    // log("User Id ${userId}");
    // log("Start Time ${startTime}");
    // log("Start Time ${endTime}");
    // log("Is Blocked or not $blocWholeDay");
    final url = Uri.parse(ApiUrls.editProfileUrl(userId));
    final headers = await getHeaders();
    final jsonBody = jsonEncode({
      "id": userId,
      "name": name,
      "phone_number": phoneNumber,
      "address": address
    });

    final response = await http.put(
      url,
      headers: headers,
      body: jsonBody,
    );
    // log("Response ::: ${response.body}");
    // log("Status in create override :::::: ${response.statusCode}");
    if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      //  log("create Override jsonResponse ${jsonResponse}");
      final deResponse = EditProfileModel.fromJson(jsonResponse);
      //log("create Override DEResponse ${deResponse}");

      return ApiResponse<EditProfileModel>(data: deResponse);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      final data = EditProfileModel.fromJson(error);
      //log("Error in availibilty REPO $error");
      return ApiResponse<EditProfileModel>(data: data);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<EditProfileModel>(data: error);
  }

  // Service For Upload Profile Picture

  Future<ApiResponse<UploadProfilePictureModel>> uploadPPRespository(
      String imagePath, String id) async {
    final token = await secureStorage.read(key: "token");

    final headers = {
      'Content-Type': 'multipart/form-data',
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    var request =
        http.MultipartRequest('POST', Uri.parse(ApiUrls.uploadPPUrl(id)))
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath(
            'file',
            imagePath,
            filename: imagePath.split('/').last,
          ));

    //log("Request ${request.files}");
    try {
      var streamedResponse = await request.send();
      // log("StreamedResponse ${streamedResponse.reasonPhrase}");
      final response = await http.Response.fromStream(streamedResponse);
      //log("header ::: ${response.headers}");
      // log("Response ::: ${response.body}");
      // log("Status :::::: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // log("jsonResponse ${jsonResponse}");
        final deResponse = UploadProfilePictureModel.fromJson(jsonResponse);
        //log("DeResponse ${deResponse.message}");
        return ApiResponse<UploadProfilePictureModel>(data: deResponse);
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        //log("jsonResponse ${jsonResponse}");
        final deResponse = UploadProfilePictureModel.fromJson(jsonResponse);
        //log("deResponse ${deResponse.message}");
        return ApiResponse<UploadProfilePictureModel>(data: deResponse);
      }
      final error = jsonDecode(response.body);

      return ApiResponse<UploadProfilePictureModel>(
          error: true, errorMessage: error, responseCode: response.statusCode);
    } catch (e) {
      // log("message $e");
      throw Exception(e);
    }
  }

// forget pass repo
  Future<ApiResponse> forgetPasswordRepository(
    String email,
  ) async {
    //log("email $email");

    final url = Uri.parse(ApiUrls.forgetPassUrl);
    final headers = await getHeaders();
    final jsonBody = jsonEncode({"email": email});

    final response = await http.post(
      url,
      headers: headers,
      body: jsonBody,
    );
    // log("Response ::: ${response.body}");
    //log("Status in create override :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      return ApiResponse(data: response.body);
    } else if (response.statusCode == 400) {
      final error = jsonDecode(response.body);
      //log("error in jsonresponse $error");
      final data = ForgetPasswordErrorModel.fromJson(error);
      //log("data in error $data");
      return ApiResponse<ForgetPasswordErrorModel>(data: data);
    }

    final error = jsonDecode(response.body);
    final data = ForgetPasswordErrorModel.fromJson(error);
    log("404 ERROR $data");
    return ApiResponse<ForgetPasswordErrorModel>(data: data);
  }

// Reset pass repo
  Future<ApiResponse<ResetPasswordModel>> resetPasswordRepository(
      String email, String oldPassword, String newPassword) async {
    log("email $email");

    final url = Uri.parse(ApiUrls.resetPassUrl);
    final headers = await getHeaders();
    final jsonBody = jsonEncode({
      "email": email,
      "old_password": oldPassword,
      "new_password": newPassword
    });

    final response = await http.put(
      url,
      headers: headers,
      body: jsonBody,
    );
    log("Response ::: ${response.body}");
    log("Status in create override :::::: ${response.statusCode}");
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      //log("create Override jsonResponse ${jsonResponse}");
      final deResponse = ResetPasswordModel.fromJson(jsonResponse);
      // log("create Override DEResponse ${deResponse}");
      return ApiResponse<ResetPasswordModel>(data: deResponse);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      final error = jsonDecode(response.body);
      log("create Override jsonResponse ${error}");
      final data = ResetPasswordModel.fromJson(error);
      log("create Override DEResponse ${data}");
      return ApiResponse<ResetPasswordModel>(data: data);
    }
    final error = jsonDecode(response.body);
    return ApiResponse<ResetPasswordModel>(data: error);
  }
}
