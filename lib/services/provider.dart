//

import 'package:flutter/material.dart';

class SplashScreenProvider extends ChangeNotifier {
  bool registering = false;
  bool logging = false;
  bool complete = false;
  bool transition = false;

  // void changeRegistering() {
  //   registering = !registering;
  //   notifyListeners();
  // }

  // void changelogging() {
  //   logging = !logging;
  //   notifyListeners();
  // }

  // void changeComplete() {
  //   complete = !complete;
  //   notifyListeners();
  // }

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
