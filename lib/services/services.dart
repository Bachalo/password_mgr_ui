//

import 'dart:convert';
import 'package:chrome_extension/services/models/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'models/response_model.dart';

class Services {
  //

  static Future<ResponseMessage> register(
      String name, String email, String password) async {
    final Uri apiUri =
        Uri.parse("https://passwordmgrapi.herokuapp.com/register");
    final response = await http.post(apiUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "name": name,
          "email": email,
          "password": password
        }));
    final ResponseMessage message = responseMessageFromJson(response.body);

    return message;
  }

  //

  static Future<ResponseMessage> login(String email, String password) async {
    final Uri apiUri = Uri.parse("https://passwordmgrapi.herokuapp.com/login");
    final response = await http.post(apiUri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{"email": email, "password": password}));
    final ResponseMessage message = responseMessageFromJson(response.body);

    return message;
  }

  //

  static Future<ResponseMessage> logout() async {
    final Uri apiUri = Uri.parse("https://passwordmgrapi.herokuapp.com/logout");
    final response = await http.post(apiUri);

    final ResponseMessage message = responseMessageFromJson(response.body);
    return message;
  }

  //

  static Future<ResponseMessage> addNew(
      String password, String email, String urlAdress) async {
    final Uri apiUri = Uri.parse("https://passwordmgrapi.herokuapp.com/add");

    final response = await http.post(
      apiUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "password": password,
          "email": email,
          "url_address": urlAdress
        },
      ),
    );
    final ResponseMessage message = responseMessageFromJson(response.body);

    return message;
  }

  //

  static Future<List<SearchResult>> search(String term) async {
    final Uri apiUri = Uri.parse("https://passwordmgrapi.herokuapp.com/search");

    final response = await http.post(
      apiUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "searchTerm": term,
        },
      ),
    );

    print(response.statusCode);
    final List<SearchResult> message = searchResultFromJson(response.body);

    print(response.body);

    return message;
  }
}

class SharedPrefs {
  static Future<bool> setPref(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    return value;
  }

  static Future<bool> getPref(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final status = prefs.getBool(key) ?? false;
    return status;
  }
}
