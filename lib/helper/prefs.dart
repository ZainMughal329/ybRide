import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'network_con.dart';

class Pref {

  // static bool isDarkMode = false;

  static late Box _box;

  static Future<void> initialize() async {
    Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
    _box = Hive.box();
  }

  static bool get isDarkMode => _box.get('isDarkMode' , defaultValue: false);

  static set isDarkMode(bool v) => _box.put('isDarkMode', v);

  static ThemeMode  defaultTheme() {
    final data = _box.get('isDarkMode');
    if(data == null) return ThemeMode.system;
    if(data == true) return ThemeMode.dark;
    return ThemeMode.light;
  }

  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }

}
