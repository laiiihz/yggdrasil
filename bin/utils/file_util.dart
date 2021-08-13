import 'dart:io';

import 'package:path/path.dart';
import 'package:uuid/uuid.dart';

class FileUtil {
  static Directory appDir = Directory('./files/apks');
  static Directory avatar = Directory('./files/avatar');
  static Future init() async {
    await createIfNot(appDir);
    await createIfNot(avatar);
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

  static Future<String> storeAvatar(List<int> binary, String extension) async {
    final uuid = Uuid().v4();
    final file = File(join(avatar.path, '$uuid.$extension'));
    await file.create();
    await file.writeAsBytes(binary);
    return '$uuid.$extension';
  }

  static Future<List<int>?> getAvatar(String name) async {
    final file = File(join(avatar.path, name));
    if (await file.exists()) {
      return await file.readAsBytes();
    }
  }
}
