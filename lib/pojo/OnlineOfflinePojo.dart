// To parse this JSON data, do
//
//     final onlineOfflinePojo = onlineOfflinePojoFromJson(jsonString);

import 'dart:convert';

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

class User {
  User({
    this.onlineOffline,
  });

  int onlineOffline;

  factory User.fromJson(Map<String, dynamic> json) => User(
    onlineOffline: json["online_offline"],
  );

  Map<String, dynamic> toJson() => {
    "online_offline": onlineOffline,
  };
}
