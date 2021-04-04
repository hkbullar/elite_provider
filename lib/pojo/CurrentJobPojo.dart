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
  DBooking bookings;

  factory CurrentJob.fromJson(Map<String, dynamic> json) => CurrentJob(
    id: json["id"],
    createdBy: json["created_by"],
    guradId: json["gurad_id"],
    bookingId: json["booking_id"],
    startJob: json["start_job"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bookings: DBooking.fromJson(json["bookings"]),
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

class DBooking {
  DBooking({
    this.id,
    this.userId,
    this.destinationLocation,
    this.arrivalLocation,
    this.date,
    this.time,
    this.isAdmin,
    this.price,
    this.status,
    this.comment,
    this.latitude,
    this.longitude,
    this.securityGuard,
    this.acceptReject,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String destinationLocation;
  String arrivalLocation;
  DateTime date;
  String time;
  int isAdmin;
  int price;
  int status;
  String comment;
  dynamic latitude;
  dynamic longitude;
  int securityGuard;
  int acceptReject;
  DateTime createdAt;
  DateTime updatedAt;

  factory DBooking.fromJson(Map<String, dynamic> json) => DBooking(
    id: json["id"],
    userId: json["user_id"],
    destinationLocation: json["destination_location"],
    arrivalLocation: json["arrival_location"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    isAdmin: json["is_admin"],
    price: json["price"],
    status: json["status"],
    comment: json["comment"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    securityGuard: json["security_guard"],
    acceptReject: json["accept_reject"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "destination_location": destinationLocation,
    "arrival_location": arrivalLocation,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "is_admin": isAdmin,
    "price": price,
    "status": status,
    "comment": comment,
    "latitude": latitude,
    "longitude": longitude,
    "security_guard": securityGuard,
    "accept_reject": acceptReject,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
