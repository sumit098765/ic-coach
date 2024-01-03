import 'dart:developer';

class GetSingleReservationModel {
  final ReservationData? combinedReservation;

  GetSingleReservationModel(
      {required this.combinedReservation, });

  factory GetSingleReservationModel.fromJson(Map<String, dynamic> json) {
    final dynamic combinedReservationJson = json['data']['combinedReservation'];

   //log("what the heck is null $combinedReservationJson");
    if (combinedReservationJson != null) {
      return GetSingleReservationModel(
     
        combinedReservation: combinedReservationJson != null
            ? ReservationData.fromJson(combinedReservationJson)
            : null,
   
      );
    } else {
      return GetSingleReservationModel(
        combinedReservation: null,
      
      );
    }
  }
}


class ReservationData {
  final String? reservationId;
  final String? orderId;
  final String? listingId;
  final String? productId;
  final String? listingProductId;
  final String? groupLeaderUserId;
  final String? location;
  final String? description;
  final String? skillLevel;
  final String? ageRange;
  final String? status;
  final String? type;
  final String? preRequisites;
  final String? notes;
  final String? outcomes;
  //final ChatMembers? chatMembers;
  final String? price;
  final String? duration;
  final String? maxGroupSize;
  final String? units;
  final String? sessionType;
  final String? purchaseType;
  final String? sessionTitle;
  final String? operationsStatus;
  final String? onschedAppointmentId;
  final String? onschedEventTime;
  final bool? newMessageNotification;
  final num? numMembers;
  final bool? deleted;
  final String? createdAt;
  final String? updatedAt;
  final String? joinUrl;
  final String? startUrl;
  final String? clientPhoneNumber;
  final String? timezoneName;
  final String? sessionDetail;
  final String? emailReminder;
  final bool? reqRescheduleStatus;
  final bool? reqCancelStatus;
  final bool? reqConfirmStatus;
  final int? onSchedServiceId;
  final String? id;
  final String? name;
  final String? email;
  final String? stripeCustomerId;
  final String? avatar;
  final String? bio;
  final String? onSchedCustomerId;
  final bool? verified;
  final String? userType;
  final String? username;
  final String? reservationUsersId;
  final String? userId;
  final String? coachId;
  final String? handle;
  final bool? isActive;
  final List<String>? photos;
  final List<String>? videos;
  final String? tagline;
  final String? onSchedResourceId;
  final String? stripeConnectedAccountId;
  final String? takeRate;
  final String? preferedAgeRange;
  final String? activityId;
  final String? positionId;
  final bool? showLessonsGiven;
  final String? rankScore;
  final bool? recommended;
  final List<String>? skillset;
  // final Socials? socials;
  final String? lessonsGiven;
  final String? city;
  final String? state;
  final String? country;
  final String? bookingFeature;
  final List<String>? nearbyCities;
  final String? whatsIncluded;
  final double? latitude;
  final double? longitude;
  final String? spatLocation;
  final bool? isZoomUser;
  final String? reservationCoachesId;

  ReservationData({
    required this.reservationId,
    required this.orderId,
    required this.listingId,
    required this.productId,
    required this.listingProductId,
    required this.groupLeaderUserId,
    required this.location,
    required this.description,
    required this.skillLevel,
    required this.ageRange,
    required this.status,
    required this.type,
    required this.preRequisites,
    required this.notes,
    required this.outcomes,
    // required this.chatMembers,
    required this.price,
    required this.duration,
    required this.maxGroupSize,
    required this.units,
    required this.sessionType,
    required this.purchaseType,
    required this.sessionTitle,
    required this.operationsStatus,
    required this.onschedAppointmentId,
    required this.onschedEventTime,
    required this.newMessageNotification,
    required this.numMembers,
    required this.deleted,
    required this.createdAt,
    required this.updatedAt,
    required this.joinUrl,
    required this.startUrl,
    required this.clientPhoneNumber,
    required this.timezoneName,
    required this.sessionDetail,
    required this.emailReminder,
    required this.reqRescheduleStatus,
    required this.reqCancelStatus,
    required this.reqConfirmStatus,
    required this.onSchedServiceId,
    required this.id,
    required this.name,
    required this.email,
    required this.stripeCustomerId,
    required this.avatar,
    required this.bio,
    required this.onSchedCustomerId,
    required this.verified,
    required this.userType,
    required this.username,
    required this.reservationUsersId,
    required this.userId,
    required this.coachId,
    required this.handle,
    required this.isActive,
    required this.photos,
    required this.videos,
    required this.tagline,
    required this.onSchedResourceId,
    required this.stripeConnectedAccountId,
    required this.takeRate,
    required this.preferedAgeRange,
    required this.activityId,
    required this.positionId,
    required this.showLessonsGiven,
    required this.rankScore,
    required this.recommended,
    required this.skillset,
    // required this.socials,
    required this.lessonsGiven,
    required this.city,
    required this.state,
    required this.country,
    required this.bookingFeature,
    required this.nearbyCities,
    required this.whatsIncluded,
    required this.latitude,
    required this.longitude,
    required this.spatLocation,
    required this.isZoomUser,
    required this.reservationCoachesId,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
    log("value ${json['price']}");
    return ReservationData(
      reservationId:
          json.containsKey('reservation_id') ? json['reservation_id'] : null,
      orderId: json.containsKey('order_id') ? json['order_id'] : null,
      listingId: json.containsKey('listing_id') ? json['listing_id'] : null,
      productId: json.containsKey('product_id') ? json['product_id'] : null,
      listingProductId: json.containsKey('listing_product_id')
          ? json['listing_product_id']
          : null,
      groupLeaderUserId: json.containsKey('group_leader_user_id')
          ? json['group_leader_user_id']
          : null,
      location: json.containsKey('location') ? json['location'] : null,
      description: json.containsKey('description') ? json['description'] : null,
      skillLevel: json.containsKey('skill_level') ? json['skill_level'] : null,
      ageRange: json.containsKey('age_range') ? json['age_range'] : null,
      status: json.containsKey('status') ? json['status'] : null,
      type: json.containsKey('type') ? json['type'] : null,
      preRequisites:
          json.containsKey('pre_requisites') ? json['pre_requisites'] : null,
      notes: json.containsKey('notes') ? json['notes'] : null,
      outcomes: json.containsKey('outcomes') ? json['outcomes'] : null,
      // chatMembers: ChatMembers.fromJson(
      //     json.containsKey('chat_members') ? json['chat_members'] : {}),
      price: json.containsKey('price') ? json['price'] : null,
      duration: json.containsKey('duration') ? json['duration'] : null,
      maxGroupSize:
          json.containsKey('max_group_size') ? json['max_group_size'] : null,
      units: json.containsKey('units') ? json['units'] : null,
      sessionType:
          json.containsKey('session_type') ? json['session_type'] : null,
      purchaseType:
          json.containsKey('purchase_type') ? json['purchase_type'] : null,
      sessionTitle:
          json.containsKey('session_title') ? json['session_title'] : null,
      operationsStatus: json.containsKey('operations_status')
          ? json['operations_status']
          : null,
      onschedAppointmentId: json.containsKey('onsched_appointment_id')
          ? json['onsched_appointment_id']
          : null,
      onschedEventTime: json.containsKey('onsched_event_time')
          ? json['onsched_event_time']
          : null,
      newMessageNotification: json.containsKey('new_message_notification')
          ? json['new_message_notification']
          : null,
      numMembers: json.containsKey('num_members') ? json['num_members'] : null,
      deleted: json.containsKey('deleted') ? json['deleted'] : null,
      createdAt: json.containsKey('created_at') ? json['created_at'] : null,
      updatedAt: json.containsKey('updated_at') ? json['updated_at'] : null,
      joinUrl: json.containsKey('join_url') ? json['join_url'] : null,
      startUrl: json.containsKey('start_url') ? json['start_url'] : null,
      clientPhoneNumber: json.containsKey('client_phone_number')
          ? json['client_phone_number']
          : null,
      timezoneName:
          json.containsKey('timezone_name') ? json['timezone_name'] : null,
      sessionDetail:
          json.containsKey('session_detail') ? json['session_detail'] : null,

      emailReminder:
          json.containsKey('email_reminder') ? json['email_reminder'] : null,
      reqRescheduleStatus: json.containsKey('req_reschedule_status')
          ? json['req_reschedule_status']
          : null,
      reqCancelStatus: json.containsKey('req_cancel_status')
          ? json['req_cancel_status']
          : null,
      reqConfirmStatus: json.containsKey('req_confirm_status')
          ? json['req_confirm_status']
          : null,

      onSchedServiceId: json.containsKey('on_sched_service_id')
          ? json['on_sched_service_id']
          : null,
      id: json.containsKey('id') ? json['id'] : null,
      name: json.containsKey('name') ? json['name'] : null,
      email: json.containsKey('email') ? json['email'] : null,
      stripeCustomerId: json.containsKey('stripe_customer_id')
          ? json['stripe_customer_id']
          : null,
      avatar: json.containsKey('avatar') ? json['avatar'] : null,
      bio: json.containsKey('bio') ? json['bio'] : null,
      onSchedCustomerId: json.containsKey('onsched_customer_id')
          ? json['onsched_customer_id']
          : null,
      verified: json.containsKey('verified') ? json['verified'] : null,
      userType: json.containsKey('user_type') ? json['user_type'] : null,
      username: json.containsKey('username') ? json['username'] : null,
      reservationUsersId: json.containsKey('reservation_users_id')
          ? json['reservation_users_id']
          : null,
      userId: json.containsKey('user_id') ? json['user_id'] : null,
      coachId: json.containsKey('coach_id') ? json['coach_id'] : null,
      handle: json.containsKey('handle') ? json['handle'] : null,
      isActive: json.containsKey('is_active') ? json['is_active'] : null,
      photos:
          json.containsKey('photos') ? List<String>.from(json['photos']) : null,
      videos:
          json.containsKey('videos') ? List<String>.from(json['videos']) : null,
      tagline: json.containsKey('tagline') ? json['tagline'] : null,
      onSchedResourceId: json.containsKey('onsched_resource_id')
          ? json['onsched_resource_id']
          : null,
      stripeConnectedAccountId: json.containsKey('stripe_connected_account_id')
          ? json['stripe_connected_account_id']
          : null,
      takeRate: json.containsKey('take_rate') ? json['take_rate'] : null,
      preferedAgeRange: json.containsKey('prefered_age_range')
          ? json['prefered_age_range']
          : null,
      activityId: json.containsKey('activity_id') ? json['activity_id'] : null,
      positionId: json.containsKey('position_id') ? json['position_id'] : null,
      showLessonsGiven: json.containsKey('show_lessons_given')
          ? json['show_lessons_given']
          : null,
      rankScore: json.containsKey('rank_score') ? json['rank_score'] : null,
      recommended: json.containsKey('recommended') ? json['recommended'] : null,
      skillset: json.containsKey('skillset')
          ? List<String>.from(json['skillset'])
          : null,
      // socials: json.containsKey('socials')
      //     ? Socials.fromJson(json['socials'])
      //     : null,
      lessonsGiven:
          json.containsKey('lessons_given') ? json['lessons_given'] : null,
      city: json.containsKey('city') ? json['city'] : null,
      state: json.containsKey('state') ? json['state'] : null,
      country: json.containsKey('country') ? json['country'] : null,
      bookingFeature:
          json.containsKey('booking_feature') ? json['booking_feature'] : null,
      nearbyCities: json.containsKey('near_by_cities')
          ? List<String>.from(json['near_by_cities'])
          : null,
      whatsIncluded:
          json.containsKey('whats_included') ? json['whats_included'] : null,
      latitude: json.containsKey('latitude') ? json['latitude'] : null,
      longitude: json.containsKey('longitude') ? json['longitude'] : null,
      spatLocation:
          json.containsKey('spat_location') ? json['spat_location'] : null,
      isZoomUser:
          json.containsKey('is_zoom_user') ? json['is_zoom_user'] : null,
      reservationCoachesId: json.containsKey('reservation_coaches_id')
          ? json['reservation_coaches_id']
          : null,
    );
  }
}






// class ChatMembers {
//   final List<Member>? members;

//   ChatMembers({required this.members});
//   factory ChatMembers.fromJson(Map<String, dynamic> json) {
//     return ChatMembers(
//       members: (json['members'] as List?)?.map((member) {
//         return Member.fromJson(member as Map<String, dynamic>);
//       }).toList(),
//     );
//   }
// }

// class Member {
//   final String? id;
//   final String? name;
//   final String? role;
//   final String? email;
//   final String? avatar;
//   final bool? upserted;

//   Member({
//     required this.id,
//     required this.name,
//     required this.role,
//     required this.email,
//     required this.avatar,
//     required this.upserted,
//   });

//   factory Member.fromJson(Map<String, dynamic> json) {
//     return Member(
//       id: json.containsKey('id') ? json['id'] : null,
//       name: json.containsKey('name') ? json['name'] : null,
//       role: json.containsKey('role') ? json['role'] : null,
//       email: json.containsKey('email') ? json['email'] : null,
//       avatar: json.containsKey('avatar') ? json['avatar'] : null,
//       upserted: json.containsKey('upserted') ? json['upserted'] : null,
//     );
//   }
// }

// class Socials {
//   final String? youTube;
//   final String? instagram;

//   Socials({required this.youTube, required this.instagram});

//   factory Socials.fromJson(Map<String, dynamic> json) {
//     return Socials(
//       youTube: json.containsKey('youTube') ? json['youTube'] : null,
//       instagram: json.containsKey('instagram') ? json['instagram'] : null,
//     );
//   }
// }
