// To parse this JSON data, do
//
//     final detailsModel = detailsModelFromJson(jsonString);

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) =>
    DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
  DetailsModel({
    required this.id,
    required this.appNAme,
    required this.password,
    required this.email,
    required this.urlAddress,
    required this.appTag,
    required this.dateAdded,
    required this.username,
  });

  int id;
  String appNAme;
  String password;
  String email;
  String urlAddress;
  String appTag;
  String dateAdded;
  String username;

  factory DetailsModel.fromJson(Map<String, dynamic> json) => DetailsModel(
        id: json["id"],
        appNAme: json["appNAme"],
        password: json["password"],
        email: json["email"],
        urlAddress: json["url_address"],
        appTag: json["appTag"],
        dateAdded: json["dateAdded"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "appNAme": appNAme,
        "password": password,
        "email": email,
        "url_address": urlAddress,
        "appTag": appTag,
        "dateAdded": dateAdded,
        "username": username,
      };
}
