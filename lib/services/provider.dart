//

import 'package:chrome_extension/services/models/search_model.dart';
import 'package:chrome_extension/services/services.dart';
import 'package:flutter/material.dart';

class PasswordProvider extends ChangeNotifier {
  List<SearchResult> passwordList = [];

  Future<List<SearchResult>> updateData() async {
    return await Services.returnAll();
  }

  updatePasswordList() async {
    passwordList = await Services.returnAll();
  }
}

class SplashScreenProvider extends ChangeNotifier {
  bool registering = false;
  bool logging = false;
  bool complete = false;
  bool transition = false;

  void showRegisterForm() {
    registering = true;
    logging = false;
    notifyListeners();
  }

  void showLoginForm() {
    registering = false;
    logging = true;
    notifyListeners();
  }

  void goBack() {
    registering = false;
    logging = false;
    notifyListeners();
  }

  void goHome() {
    transition = true;
    registering = false;
    logging = false;
    notifyListeners();
  }
}
