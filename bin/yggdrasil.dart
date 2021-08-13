import 'dart:io';
import 'dart:isolate';

import 'package:hotreloader/hotreloader.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'interceptor.dart';
import 'utils/db_util.dart';
import 'utils/file_util.dart';
import 'utils/hive_util.dart';
import 'service.dart';

void main(List<String> arguments) async {
  Logger.root.onRecord.listen((msg) =>
      (msg.level < Level.SEVERE ? stdout : stderr).write(
          '${msg.time} ${msg.level.name} [${Isolate.current.debugName}] ${msg.loggerName}: ${msg.message}\n'));
  await HotReloader.create();
  await HiveUtil.init();
  await FileUtil.init();
  await DB.connect();
  var hander = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(appInterceptor)
      .addHandler(BaseService().router);
  var server = await shelf_io.serve(hander, '0.0.0.0', 22000);
  server.autoCompress = true;
  print('SERVE AT localhost:22000');
}
