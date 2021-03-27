// To parse this JSON data, do
//
//     final onlineOfflinePojo = onlineOfflinePojoFromJson(jsonString);

import 'dart:convert';

import 'package:elite_provider/pojo/User.dart';

OnlineOfflinePojo onlineOfflinePojoFromJson(String str) => OnlineOfflinePojo.fromJson(json.decode(str));

String onlineOfflinePojoToJson(OnlineOfflinePojo data) => json.encode(data.toJson());

class OnlineOfflinePojo {
  OnlineOfflinePojo({
    this.user,
    this.message,
  });
  User user;
  String message;

  factory OnlineOfflinePojo.fromJson(Map<String, dynamic> json) => OnlineOfflinePojo(
    user: User.fromJson(json["user"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "message": message,
  };
}
