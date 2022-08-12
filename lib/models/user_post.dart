// To parse this JSON data, do
//
//     final singlePostModel = singlePostModelFromJson(jsonString);

import 'dart:convert';

SinglePostModel singlePostModelFromJson(String str) =>
    SinglePostModel.fromJson(json.decode(str));

String singlePostModelToJson(SinglePostModel data) =>
    json.encode(data.toJson());

class SinglePostModel {
  SinglePostModel({
    this.id,
    this.userId,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory SinglePostModel.fromJson(Map<String, dynamic> json) =>
      SinglePostModel(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        content: json["content"] == null ? null : json["content"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "content": content,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
