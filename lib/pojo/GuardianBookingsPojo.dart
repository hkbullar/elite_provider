import 'dart:convert';

GuardianBookingsPojo guardianBookingsPojoFromJson(String str) => GuardianBookingsPojo.fromJson(json.decode(str));

String guardianBookingsPojoToJson(GuardianBookingsPojo data) => json.encode(data.toJson());

class GuardianBookingsPojo {
  GuardianBookingsPojo({
    this.booking,
    this.message,
  });

  List<GuardianBookingPojo> booking;
  String message;

  factory GuardianBookingsPojo.fromJson(Map<String, dynamic> json) => GuardianBookingsPojo(
    booking: List<GuardianBookingPojo>.from(json["booking"].map((x) => GuardianBookingPojo.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "booking": List<dynamic>.from(booking.map((x) => x.toJson())),
    "message": message,
  };
}

class GuardianBookingPojo {
  GuardianBookingPojo({
    this.id,
    this.bookingId,
    this.guardId,
    this.status,
    this.startJob,
    this.startAt,
    this.endAt,
    this.totalHour,
    this.createdAt,
    this.updatedAt,
    this.bookings,
  });

  int id;
  int bookingId;
  int guardId;
  int status;
  int startJob;
  String startAt;
  String endAt;
  int totalHour;
  DateTime createdAt;
  DateTime updatedAt;
  List<GuardianBooking> bookings;

  factory GuardianBookingPojo.fromJson(Map<String, dynamic> json) => GuardianBookingPojo(
    id: json["id"],
    bookingId: json["booking_id"],
    guardId: json["guard_id"],
    status: json["status"],
    startJob: json["start_job"],
    startAt: json["start_at"],
    endAt: json["end_at"],
    totalHour: json["total_hour"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bookings: List<GuardianBooking>.from(json["bookings"].map((x) => GuardianBooking.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "booking_id": bookingId,
    "guard_id": guardId,
    "status": status,
    "start_job": startJob,
    "start_at": startAt,
    "end_at": endAt,
    "total_hour": totalHour,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
  };
}
class GuardianBooking {
  GuardianBooking({
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

  factory GuardianBooking.fromJson(Map<String, dynamic> json) => GuardianBooking(
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
