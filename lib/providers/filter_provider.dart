import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  int _listSize = 15;
  int? _month;
  int? _year;

  int get listSize {
    return _listSize;
  }

  set listSize(int value) {
    _listSize = value;
    notifyListeners();
  }

  int get month {
    return _month ?? DateTime.now().month;
  }

  set month(int value) {
    _month = value;
    notifyListeners();
  }

  int get year {
    return _year ?? DateTime.now().year;
  }

  set year(int value) {
    _year = value;
    notifyListeners();
  }
}
