// To parse this JSON data, do
//
//     final driverCurrentJobPojo = driverCurrentJobPojoFromJson(jsonString);

import 'dart:convert';

DriverCurrentJobPojo driverCurrentJobPojoFromJson(String str) => DriverCurrentJobPojo.fromJson(json.decode(str));

String driverCurrentJobPojoToJson(DriverCurrentJobPojo data) => json.encode(data.toJson());

class DriverCurrentJobPojo {
  DriverCurrentJobPojo({
    this.currentJob,
    this.message,
  });

  CurrentJourneyPojo currentJob;
  String message;

  factory DriverCurrentJobPojo.fromJson(Map<String, dynamic> json) => DriverCurrentJobPojo(
    currentJob: CurrentJourneyPojo.fromJson(json["current_job"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "current_job": currentJob.toJson(),
    "message": message,
  };
}

class CurrentJourneyPojo {
  CurrentJourneyPojo({
    this.id,
    this.createdBy,
    this.driverId,
    this.bookingId,
    this.startJob,
    this.createdAt,
    this.updatedAt,
    this.bookings,
  });

  int id;
  int createdBy;
  int driverId;
  int bookingId;
  int startJob;
  DateTime createdAt;
  DateTime updatedAt;
  Bookings bookings;

  factory CurrentJourneyPojo.fromJson(Map<String, dynamic> json) => CurrentJourneyPojo(
    id: json["id"],
    createdBy: json["created_by"],
    driverId: json["driver_id"],
    bookingId: json["booking_id"],
    startJob: json["start_job"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bookings: Bookings.fromJson(json["bookings"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_by": createdBy,
    "driver_id": driverId,
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
    this.userId,
    this.destinationLocation,
    this.arrivalLocation,
    this.destinationLat,
    this.destinationLong,
    this.arrivalLat,
    this.arrivalLong,
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
  String destinationLat;
  String destinationLong;
  String arrivalLat;
  dynamic arrivalLong;
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

  factory Bookings.fromJson(Map<String, dynamic> json) => Bookings(
    id: json["id"],
    userId: json["user_id"],
    destinationLocation: json["destination_location"],
    arrivalLocation: json["arrival_location"],
    destinationLat: json["destination_lat"],
    destinationLong: json["destination_long"],
    arrivalLat: json["arrival_lat"],
    arrivalLong: json["arrival_long"],
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
    "destination_lat": destinationLat,
    "destination_long": destinationLong,
    "arrival_lat": arrivalLat,
    "arrival_long": arrivalLong,
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
