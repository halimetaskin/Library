//Tema bilgilerini tutacağımız alan
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SerTehmeData extends ChangeNotifier {
  SharedPreferences? prefTheme;
  bool defaultTheme = true;

  temaDegistir() async {
    bool newThmeValue = !defaultTheme;
    defaultTheme = newThmeValue;
    await saveTheme(newThmeValue);
    notifyListeners();
  }

  Future<void> creatObje() async {
    prefTheme = await SharedPreferences.getInstance();
  }

  Future<void> saveTheme(bool ligtDark) async {
    await creatObje();
    try {
      var sonuc = prefTheme!.setBool('themeData', ligtDark);
      debugPrint('Tema değişti$sonuc');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> loadTheme() async {
    await creatObje();
    var renk = prefTheme?.getBool('themeData');
    debugPrint('load çalıştı');
    if (renk != null) {
      defaultTheme = renk;
      notifyListeners();
      return renk;
    } else {
      defaultTheme = true;
      return true;
    }
  }
}
