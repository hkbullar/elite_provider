import 'dart:convert';

import 'package:elite_provider/pojo/User.dart';

EditProfilePojo editProfilePojoFromJson(String str) => EditProfilePojo.fromJson(json.decode(str));

String editProfilePojoToJson(EditProfilePojo data) => json.encode(data.toJson());

class EditProfilePojo {
  EditProfilePojo({
    this.user,
    this.message,
  });

  User user;
  String message;

  factory EditProfilePojo.fromJson(Map<String, dynamic> json) => EditProfilePojo(
    user: User.fromJson(json["user"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
    "message": message,
  };
}