// To parse this JSON data, do
//
//     final currentJobPojo = currentJobPojoFromJson(jsonString);

import 'dart:convert';

CurrentJobPojo currentJobPojoFromJson(String str) => CurrentJobPojo.fromJson(json.decode(str));

String currentJobPojoToJson(CurrentJobPojo data) => json.encode(data.toJson());

class CurrentJobPojo {
  CurrentJobPojo({
    this.currentJob,
    this.message,
  });

  CurrentJob currentJob;
  String message;

  factory CurrentJobPojo.fromJson(Map<String, dynamic> json) => CurrentJobPojo(
    currentJob: CurrentJob.fromJson(json["current_job"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "current_job": currentJob.toJson(),
    "message": message,
  };
}

class CurrentJob {
  CurrentJob({
    this.id,
    this.createdBy,
    this.guradId,
    this.bookingId,
    this.startJob,
    this.createdAt,
    this.updatedAt,
    this.bookings,
  });

  int id;
  int createdBy;
  int guradId;
  int bookingId;
  int startJob;
  DateTime createdAt;
  DateTime updatedAt;
  Bookings bookings;

  factory CurrentJob.fromJson(Map<String, dynamic> json) => CurrentJob(
    id: json["id"],
    createdBy: json["created_by"],
    guradId: json["gurad_id"],
    bookingId: json["booking_id"],
    startJob: json["start_job"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bookings: Bookings.fromJson(json["bookings"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "gurad_id": guradId,
    "booking_id": bookingId,
    "start_job": startJob,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "bookings": bookings.toJson(),
  };
}

class Bookings {
  Bookings({
    this.id,
    this.location,
    this.locationLat,
    this.locationLong,
    this.userId,
    this.counting,
    this.fromTime,
    this.userType,
    this.toTime,
    this.fromDate,
    this.toDate,
    this.price,
    this.status,
    this.comment,
    this.latitude,
    this.longitude,
    this.selectDays,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String location;
  String locationLat;
  String locationLong;
  int userId;
  String counting;
  String fromTime;
  String userType;
  String toTime;
  DateTime fromDate;
  DateTime toDate;
  int price;
  int status;
  String comment;
  dynamic latitude;
  dynamic longitude;
  List<String> selectDays;
  DateTime createdAt;
  DateTime updatedAt;

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    id: json["id"],
    location: json["location"],
    locationLat: json["location_lat"],
    locationLong: json["location_long"],
    userId: json["user_id"],
    counting: json["counting"],
    fromTime: json["from_time"],
    userType: json["user_type"],
    toTime: json["to_time"],
    fromDate: DateTime.parse(json["from_date"]),
    toDate: DateTime.parse(json["to_date"]),
    price: json["price"],
    status: json["status"],
    comment: json["comment"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    selectDays: List<String>.from(json["select_days"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location,
    "location_lat": locationLat,
    "location_long": locationLong,
    "user_id": userId,
    "counting": counting,
    "from_time": fromTime,
    "user_type": userType,
    "to_time": toTime,
    "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
    "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
    "price": price,
    "status": status,
    "comment": comment,
    "latitude": latitude,
    "longitude": longitude,
    "select_days": List<dynamic>.from(selectDays.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
