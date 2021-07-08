//

import 'dart:convert';

List<SearchResult> searchResultFromJson(String str) => List<SearchResult>.from(
    json.decode(str).map((x) => SearchResult.fromJson(x)));

String searchResultToJson(List<SearchResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchResult {
  SearchResult({
    required this.id,
    required this.password,
    required this.email,
    required this.urlAddress,
    required this.username,
  });

  int id;
  String password;
  String email;
  String urlAddress;
  String username;

  factory SearchResult.fromJson(Map<String, dynamic> json) => SearchResult(
        id: json["id"],
        password: json["password"],
        email: json["email"],
        urlAddress: json["url_address"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "email": email,
        "url_address": urlAddress,
        "username": username,
      };
}
