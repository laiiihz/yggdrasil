import 'dart:io';

import 'package:path/path.dart';

import '../models/apk_model.dart';

class ApkUtil {
  static Future<APKModel> parse(String uuid) async {
    final model = APKModel(uuid: uuid, usesPermission: []);
    var result = await Process.run('./cmdline-tools/aapt2', [
      'dump',
      'badging',
      join('.', 'files', 'apks', '$uuid.apk'),
    ]);
    var resultStr = result.stdout.toString();
    var splitString = resultStr.split('\n');
    var permissions = <String>[];
    for (var i = 0; i < splitString.length; i++) {
      if (i == 0) {
        parsePackage(splitString[0], model);
      } else if (i == 1) {
        model.sdkVersion = splitString[i].split(':')[1].replaceAll('\'', '');
      } else if (i == 2) {
        model.targetSdkVersion =
            splitString[i].split(':')[1].replaceAll('\'', '');
      } else if (splitString[i].contains('uses-permission')) {
        permissions.add(splitString[i].split(':')[1].trim().split('=')[1]);
      }
      model.usesPermission = permissions;
    }
    return model;
  }

  static APKModel parsePackage(String package, APKModel model) {
    final values = package.split(' ');
    for (var item in values) {
      final keyValueItems = item.split('=');
      if (keyValueItems.length >= 2) {
        if (keyValueItems[0] == 'name') {
          model.name = keyValueItems[1].replaceAll('\'', '');
        }
        if (keyValueItems[0] == 'versionCode') {
          model.versionCode = keyValueItems[1].replaceAll('\'', '');
        }
        if (keyValueItems[0] == 'versionName') {
          model.versionName = keyValueItems[1].replaceAll('\'', '');
        }
      }
    }
    print(model.versionName);
    return model;
  }
}
