import 'dart:convert';

import 'package:elite_provider/pojo/User.dart';

LoginPojo loginPojoFromJson(String str) => LoginPojo.fromJson(json.decode(str));

String loginPojoToJson(LoginPojo data) => json.encode(data.toJson());

class LoginPojo {
  LoginPojo({
    this.token,
    this.user,
  });

  String token;
  User user;

  factory LoginPojo.fromJson(Map<String, dynamic> json) => LoginPojo(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };
}