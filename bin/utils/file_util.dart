import 'dart:io';

import 'package:path/path.dart';

class FileUtil {
  static Directory appDir = Directory('./files/apks');
  static Future init() async {
    await createIfNot(appDir);
  }

  static Future storeApk(List<int> binary, String name) async {
    final file = File(join(appDir.path, name));
    await file.create();
    await file.writeAsBytes(binary);
  }

  static Future createIfNot(Directory file) async {
    if (!await file.exists()) {
      await file.create(recursive: true);
    }
  }
}
