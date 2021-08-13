import 'dart:io';

import 'package:hive/hive.dart';

class HiveUtil {
  static Future init() async {
    var dir = Directory('./files/hive_store');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    Hive.init(dir.path);
    await Hive.openBox('config');
  }

  static Box get configBox => Hive.box('config');
}
