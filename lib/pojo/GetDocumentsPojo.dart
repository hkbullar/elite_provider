// To parse this JSON data, do
//
//     final getDocumentsPojo = getDocumentsPojoFromJson(jsonString);

import 'dart:convert';

GetDocumentsPojo getDocumentsPojoFromJson(String str) => GetDocumentsPojo.fromJson(json.decode(str));

String getDocumentsPojoToJson(GetDocumentsPojo data) => json.encode(data.toJson());

class GetDocumentsPojo {
  GetDocumentsPojo({
    this.docDetails,
    this.message,
  });

  List<DocDetail> docDetails;
  String message;

  factory GetDocumentsPojo.fromJson(Map<String, dynamic> json) => GetDocumentsPojo(
    docDetails: List<DocDetail>.from(json["doc_details"].map((x) => DocDetail.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "doc_details": List<dynamic>.from(docDetails.map((x) => x.toJson())),
    "message": message,
  };
}

class DocDetail {
  DocDetail({
    this.id,
    this.imageType,
    this.image,
    this.userId,
    this.type,
    this.approve,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String imageType;
  String image;
  int userId;
  String type;
  int approve;
  DateTime createdAt;
  DateTime updatedAt;

  factory DocDetail.fromJson(Map<String, dynamic> json) => DocDetail(
    id: json["id"],
    imageType: json["image_type"],
    image: json["image"],
    userId: json["user_id"],
    type: json["type"],
    approve: json["approve"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image_type": imageType,
    "image": image,
    "user_id": userId,
    "type": type,
    "approve": approve,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
