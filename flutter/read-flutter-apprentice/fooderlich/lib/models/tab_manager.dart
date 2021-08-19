import 'package:flutter/material.dart';

class TabManager extends ChangeNotifier {
  int selectedTab = 0;

  void goToTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  void goToRecipes() => goToTab(1);
}
