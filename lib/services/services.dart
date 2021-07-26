//

import 'dart:convert';
import 'package:chrome_extension/services/models/details_model.dart';
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

  static Future<ResponseMessage> edit(
      int id,
      String oldAppName,
      String oldPassword,
      String oldEmail,
      String oldUrlAdress,
      String oldAppTag,
      String newAppName,
      String newPassword,
      String newEmail,
      String newUrlAdress,
      String newAppTag) async {
    final Uri apiUri = Uri.parse("https://passwordmgrapi.herokuapp.com/edit");

    final response = await http.post(
      apiUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(
        {
          "id": id,
          "oldPassInfo": {
            "appName": oldAppName,
            "password": oldPassword,
            "email": oldEmail,
            "url_address": oldUrlAdress,
            "appTag": oldAppTag
          },
          "NewPassInfo": {
            "appName": newAppName,
            "password": newPassword,
            "email": newEmail,
            "url_address": newUrlAdress,
            "appTag": newAppTag
          }
        },
      ),
    );
    return ResponseMessage(response: "ok");
  }

  //

  static Future<ResponseMessage> remove(String appName, String password,
      String email, String urlAdress, String appTag) async {
    final Uri apiUri = Uri.parse("https://passwordmgrapi.herokuapp.com/remove");

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

  static Future<List<SearchResult>> returnAll() async {
    final Uri apiUri =
        Uri.parse("https://passwordmgrapi.herokuapp.com/returnAll");

    final response = await http.get(
      apiUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    final List<SearchResult> message = searchResultFromJson(response.body);
    return message;
  }

  //

  static Future<DetailsModel> getDetails(int id) async {
    final Uri apiUri =
        Uri.parse("https://passwordmgrapi.herokuapp.com/getDetails");

    final response = await http.post(
      apiUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, int>{
          "searchId": id,
        },
      ),
    );
    final DetailsModel message = detailsModelFromJson(response.body);
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
