// To parse this JSON data, do
//
//     final editData = editDataFromJson(jsonString);

import 'dart:convert';

EditData editDataFromJson(String str) => EditData.fromJson(json.decode(str));

String editDataToJson(EditData data) => json.encode(data.toJson());

class EditData {
  EditData({
    required this.id,
    required this.oldPassInfo,
    required this.newPassInfo,
  });

  int id;
  PassInfo oldPassInfo;
  PassInfo newPassInfo;

  factory EditData.fromJson(Map<String, dynamic> json) => EditData(
        id: json["id"],
        oldPassInfo: PassInfo.fromJson(json["oldPassInfo"]),
        newPassInfo: PassInfo.fromJson(json["NewPassInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "oldPassInfo": oldPassInfo.toJson(),
        "NewPassInfo": newPassInfo.toJson(),
      };
}

class PassInfo {
  PassInfo({
    required this.appName,
    required this.password,
    required this.email,
    required this.urlAddress,
    required this.appTag,
  });

  String appName;
  String password;
  String email;
  String urlAddress;
  String appTag;

  factory PassInfo.fromJson(Map<String, dynamic> json) => PassInfo(
        appName: json["appName"],
        password: json["password"],
        email: json["email"],
        urlAddress: json["url_address"],
        appTag: json["appTag"],
      );

  Map<String, dynamic> toJson() => {
        "appName": appName,
        "password": password,
        "email": email,
        "url_address": urlAddress,
        "appTag": appTag,
      };
}
