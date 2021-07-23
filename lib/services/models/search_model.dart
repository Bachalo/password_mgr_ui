// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

List<SearchResult> searchResultFromJson(String str) => List<SearchResult>.from(
    json.decode(str).map((x) => SearchResult.fromJson(x)));

String searchResultToJson(List<SearchResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResult {
  SearchResult({
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

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
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
