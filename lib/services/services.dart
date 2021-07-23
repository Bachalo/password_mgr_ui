//

import 'dart:convert';
import 'package:chrome_extension/services/models/search_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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

  static Future<ResponseMessage> addNew(String appName, String password,
      String email, String urlAdress, String appTag) async {
    final Uri apiUri = Uri.parse("https://passwordmgrapi.herokuapp.com/add");

    final response = await http.post(
      apiUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          "appName": appName,
          "password": password,
          "email": email,
          "url_address": urlAdress,
          "appTag": appTag,
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
    print(response.body);
    if (response.body.length <= 2) {
      return [];
    }
    final List<SearchResult> message = searchResultFromJson(response.body);
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

void launchTOS() async => await canLaunch('https://flutter.dev')
    ? await launch('https://flutter.dev')
    : throw 'Could not launch https://flutter.dev';
