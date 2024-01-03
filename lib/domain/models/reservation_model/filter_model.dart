// ignore_for_file: non_constant_identifier_names



class FilterModel {
  Data? data;
  FilterModel({this.data});

  factory FilterModel.fromJson(Map<String, dynamic> json) {
   // log("is data null ${json['data']}");
    return FilterModel(data: Data.fromJson(json['data']));
  }
}

class Data {
  Reservation? reservation;

  Data({this.reservation});

  factory Data.fromJson(Map<String, dynamic> json) {
     //log("is reservation null ${json['reservation']}");
    return Data(reservation: Reservation.fromJson(json['reservation']));
  }
}

class Reservation {
  List<Rows>? rows;
  var count;

  Reservation({this.rows, this.count});
  factory Reservation.fromJson(Map<String, dynamic> json) {
    //  log("is rows null ${json['rows']}");
    var list =
        json['rows'] as List<dynamic>?; 
    List<Rows>? rowList;
    if (list != null) {

      rowList = list
          .map((i) => Rows.fromJson(i))
          .toList()
          .cast<Rows>(); 
    }

    return Reservation(rows: rowList, count: json['count']);
  }
}

class Rows {
  //Coach? coach;
  ReservationData? reservation;
  User? user;

  Rows({ this.reservation, this.user});

  factory Rows.fromJson(Map<String, dynamic> json) {
      // log("is ReservationData null ${json['reservation']}");
      //   log("is user null ${json['user']}");
    return Rows(
      //coach: Coach.fromJson(json['coach']),
      reservation: ReservationData.fromJson(json['reservation']),
      user: User.fromJson(json['user']),
    );
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
 // final ChatMembers? chatMembers;
  final num? price;
  final num? duration;
  final num? maxGroupSize;
  final num? units;
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
  final List<String>? properties;

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
    required this.properties,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) {
   // log("Null value ${json['price']}");
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
      properties: json.containsKey('properties')
          ? List<String>.from(json['properties'])
          : [],
    );
  }
}

class ChatMembers {
  final List<Member>? members;

  ChatMembers({required this.members});

  factory ChatMembers.fromJson(Map<String, dynamic> json) {
    final membersList = json['members'] as List<dynamic>;

    final members =
        membersList.map((member) => Member.fromJson(member)).toList();
    return ChatMembers(members: members);
  }
}

class Member {
  final String? id;
  final String? name;
  final String? role;
  final String? email;
  final String? avatar;
  final bool? upserted;

  Member({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.avatar,
    required this.upserted,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json.containsKey('id') ? json['id'] : null,
      name: json.containsKey('name') ? json['name'] : null,
      role: json.containsKey('role') ? json['role'] : null,
      email: json.containsKey('email') ? json['email'] : null,
      avatar: json.containsKey('avatar') ? json['avatar'] : null,
      upserted: json.containsKey('upserted') ? json['upserted'] : null,
    );
  }
}

class Coach {
  final String? coach_id;
  final String? user_id;
  final String? description;
  final String? handle;
  final bool? is_active;
  final List<String>? photos;
  final List<String>? videos;
  final String? tagline;
  final String? onsched_resource_id;
  final String? stripe_connected_account_id;
  final double? take_rate;
  final String? prefered_age_range;
  final String? activity_id;
  final String? position_id;
  final bool? show_lessons_given;
  final String? location;
  final int? rank_score;
  final bool? recommended;
  final List<String>? skillset;
  final Socials? socials;
  final int? lessons_given;
  final String? city;
  final String? state;
  final String? country;
  final String? booking_feature;
  final List<String>? near_by_cities;
  final bool? deleted;
  final String? created_at;
  final String? updated_at;
  final String? whats_included;
  final double? latitude;
  final double? longitude;
  final String? spat_location;
  final bool? is_zoom_user;

  Coach({
    this.coach_id,
    this.user_id,
    this.description,
    this.handle,
    this.is_active,
    this.photos,
    this.videos,
    this.tagline,
    this.onsched_resource_id,
    this.stripe_connected_account_id,
    this.take_rate,
    this.prefered_age_range,
    this.activity_id,
    this.position_id,
    this.show_lessons_given,
    this.location,
    this.rank_score,
    this.recommended,
    this.skillset,
    this.socials,
    this.lessons_given,
    this.city,
    this.state,
    this.country,
    this.booking_feature,
    this.near_by_cities,
    this.deleted,
    this.created_at,
    this.updated_at,
    this.whats_included,
    this.latitude,
    this.longitude,
    this.spat_location,
    this.is_zoom_user,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      coach_id: json['coach_id'],
      user_id: json['user_id'],
      description: json['description'],
      handle: json['handle'],
      is_active: json['is_active'],
      photos: List<String>.from(json['photos']),
      videos: List<String>.from(json['videos']),
      tagline: json['tagline'],
      onsched_resource_id: json['onsched_resource_id'],
      stripe_connected_account_id: json['stripe_connected_account_id'],
      take_rate: json['take_rate'],
      prefered_age_range: json['prefered_age_range'],
      activity_id: json['activity_id'],
      position_id: json['position_id'],
      show_lessons_given: json['show_lessons_given'],
      location: json['location'],
      rank_score: json['rank_score'],
      recommended: json['recommended'],
      skillset: List<String>.from(json['skillset']),
      socials: Socials.fromJson(json['socials']),
      lessons_given: json['lessons_given'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      booking_feature: json['booking_feature'],
      near_by_cities: List<String>.from(json['near_by_cities']),
      deleted: json['deleted'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      whats_included: json['whats_included'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      spat_location: json['spat_location'],
      is_zoom_user: json['is_zoom_user'],
    );
  }
}

class Socials {
  final String? youTube;
  final String? instagram;

  Socials({this.youTube, this.instagram});

  factory Socials.fromJson(Map<String, dynamic> json) {
    return Socials(youTube: json['youTube'], instagram: json['instagram']);
  }
}

class User {
  final String? id;
  final String? name;
  final String? email;
  final String? stripe_customer_id;
  final String? avatar;
  final String? bio;
  final String? onsched_customer_id;
  final bool? verified;
  final bool? deleted;
  final String? created_at;
  final String? updated_at;
  final String? user_type;
  final String? username;

  User(
      {this.id,
      this.name,
      this.email,
      this.stripe_customer_id,
      this.avatar,
      this.bio,
      this.onsched_customer_id,
      this.verified,
      this.deleted,
      this.created_at,
      this.updated_at,
      this.user_type,
      this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      stripe_customer_id: json['stripe_customer_id'],
      avatar: json['avatar'],
      bio: json['bio'],
      onsched_customer_id: json['onsched_customer_id'],
      verified: json['verified'],
      deleted: json['deleted'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      user_type: json['user_type'],
      username: json['username'],
    );
  }
}
