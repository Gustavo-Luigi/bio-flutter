import 'package:flutter/material.dart';

import 'package:bio_flutter/screens/form_screen.dart';
import 'package:bio_flutter/screens/home_screen.dart';
import 'package:bio_flutter/screens/measurements_screen.dart';

enum Screen { home, list, form }

class ScreenProvider with ChangeNotifier {
  Screen _selectedScreen = Screen.home;

  get selectedScreen {
    return _selectedScreen;
  }

  set selectedScreen(value) {
    _selectedScreen = value;
    notifyListeners();
  }

  Widget displaySelectedScreen() {
    switch (selectedScreen) {
      case Screen.list:
        return const MeasurementsScreen();
      case Screen.form:
        return const FormScreen();
      default:
        return const HomeScreen();
    }
  }
}
