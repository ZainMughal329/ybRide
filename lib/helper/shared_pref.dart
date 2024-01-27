import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  Future<void> setIsFirstOpen(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('IsFirstOpen', value);
  }

  Future<bool?> getIsFirstOpen() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('IsFirstOpen') ?? false;
  }
}