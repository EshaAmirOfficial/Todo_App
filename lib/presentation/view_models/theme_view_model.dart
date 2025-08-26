import 'package:flutter/cupertino.dart';

class ThemeChange extends ChangeNotifier{
  bool _isDarkMode=false;

  bool getThemeVal()=> _isDarkMode;

  void themeUpdate({required bool value}){
    _isDarkMode=value;
    notifyListeners();
}
}