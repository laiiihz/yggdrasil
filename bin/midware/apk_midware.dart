import 'package:uuid/uuid.dart';

import '../models/apk_model.dart';
import '../utils/apk_util.dart';
import '../utils/db_util.dart';
import '../utils/file_util.dart';
import '../utils/postgres_helper.dart';

class ApkMid {
  static Future addApk(APKModel model, String channel) async {
    await PostgresHelper.insert('apk_t', {
      'uuid': model.uuid,
      'name': model.name,
      'versionCode': model.versionCode,
      'versionName': model.versionName,
      'sdkVersion': model.sdkVersion,
      'targetSdkVersion': model.targetSdkVersion,
      'usesPermission': model.usesPermission,
      'channel_id': channel,
    });
  }

  static Future<List<APKModel>> getList() async {
    var result = await DB.connection.query(
      'select * from apk_t',
    );
    if (result.isEmpty) return [];
    return result.map((e) {
      return APKModel(
        uuid: e[0],
        name: e[1],
        versionCode: e[2],
        versionName: e[3],
        sdkVersion: e[4],
        targetSdkVersion: e[5],
        usesPermission: e[6],
      );
    }).toList();
  }

  static Future<bool> checkApp(String name) async {
    return (await DB.connection.query(
      'select * from app_t where name = @name',
      substitutionValues: {'name': name},
    ))
        .isNotEmpty;
  }

  static Future addApp(String name) async {
    await PostgresHelper.insert('app_t', {
      'uuid': Uuid().v4(),
      'name': name,
      'avatar': null,
    });
  }

  static Future<List> apps() async {
    var result = await DB.connection.query('select * from app_t');
    return result
        .map((e) => {
              'uuid': e[0],
              'name': e[1],
              'avatar': e[2],
            })
        .toList();
  }

  static Future<bool> checkAppById(String uuid) async {
    return (await DB.connection.query(
      'select * from app_t where uuid = @uuid',
      substitutionValues: {'uuid': uuid},
    ))
        .isNotEmpty;
  }

  static Future addChannel(String name, String uuid) async {
    await PostgresHelper.insert('app_channel_t', {
      'id': Uuid().v4(),
      'name': name,
      'app_id': uuid,
    });
  }

  static Future<bool> checkChannelById(String uuid) async {
    var result = await DB.connection.query(
      'select * from app_channel_t where uuid=@uuid',
      substitutionValues: {'uuid': uuid},
    );
    return result.isNotEmpty;
  }

  static Future<List> getChannels() async {
    var result = await DB.connection.query('select * from app_channel_t');
    return result
        .map((e) => {
              'uuid': e[0],
              'name': e[1],
              'app_id': e[2],
            })
        .toList();
  }

  static Future<bool> checkChannelByName(String name) async {
    var result = await DB.connection.query(
      'select * from app_channel_t where name=@name',
      substitutionValues: {'name': name},
    );
    return result.isNotEmpty;
  }

  static Future addAPK(List<int> binary, String channel) async {
    var uuid = Uuid().v4();
    var name = '$uuid.apk';
    await FileUtil.storeApk(binary, name);
    final model = await ApkUtil.parse(uuid);
    await addApk(model, channel);
  }
}
