class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phoneNo,
    this.image,
    this.gender,
    this.emailVerifiedAt,
    this.onlineOffline,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  dynamic phoneNo;
  dynamic image;
  dynamic gender;
  dynamic emailVerifiedAt;
  dynamic onlineOffline;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNo: json["phone_no"],
    image: json["image"],
    gender: json["gender"],
    emailVerifiedAt: json["email_verified_at"],
    onlineOffline: json["online_offline"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_no": phoneNo,
    "image": image,
    "gender": gender,
    "email_verified_at": emailVerifiedAt,
    "online_offline": onlineOffline,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}