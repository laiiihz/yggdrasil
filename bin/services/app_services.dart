import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../custom_response.dart';
import '../midware/apk_midware.dart';
import '../models/base_model.dart';

part 'app_services.g.dart';

class AppServices {
  Router get router => _$AppServicesRouter(this);
  @Route.put('/apps')
  Future<Response> setApp(Request request) async {
    final map = request.url.queryParameters;
    final name = map['name'];
    if (name == null) {
      return R
          .ok(BaseModel(code: 500, message: '参数错误', data: null, list: null));
    }
    if (await ApkMid.checkApp(name)) {
      return R
          .ok(BaseModel(code: 500, message: '已存在该app', data: null, list: null));
    }
    await ApkMid.addApp(name);
    return R.ok(BaseModel(code: 200, message: '创建成功', data: null, list: null));
  }

  @Route.get('/apps')
  Future<Response> apps(Request request) async {
    final items = await ApkMid.apps();
    return R.ok(BaseModel(code: 200, message: '', data: null, list: items));
  }

  @Route.put('/channel')
  Future<Response> setChannel(Request request) async {
    final map = request.url.queryParameters;
    final name = map['name'];
    final appId = map['uuid'];
    if (name == null || appId == null) {
      return R
          .ok(BaseModel(code: 500, message: '参数错误', data: null, list: null));
    }
    if (!await ApkMid.checkAppById(appId)) {
      return R
          .ok(BaseModel(code: 500, message: '没有该app', data: null, list: null));
    }
    if (await ApkMid.checkChannelByName(name)) {
      return R.ok(
          BaseModel(code: 500, message: '已存在该channel', data: null, list: null));
    }
    await ApkMid.addChannel(name, appId);
    return R.ok(BaseModel(code: 200, message: '创建成功', data: null, list: null));
  }

  @Route.get('/channel')
  Future<Response> getChannel(Request request) async {
    var items = await ApkMid.getChannels();
    return R.ok(BaseModel(code: 200, message: '', data: null, list: items));
  }

  @Route.post('/upload')
  Future<Response> upload(Request request) async {
    var channel = request.url.queryParameters['channel'];
    if (channel == null) {
      return R.ok(BaseModel(
        code: 500,
        message: '请检查channel参数',
        data: null,
        list: null,
      ));
    }
    if (!await ApkMid.checkChannelById(channel)) {
      return R.ok(BaseModel(
        code: 500,
        message: '不存在该channel',
        data: null,
        list: null,
      ));
    }
    final contentType = request.headers['Content-Type'] ?? '';
    String? type = extensionFromMime(contentType);
    if (type == 'apk') {
      var binary = <int>[];
      var list = await request.read().toList();
      for (var item in list) {
        binary.addAll(item);
      }
      await ApkMid.addAPK(binary, channel);
      return R.ok(BaseModel(
        code: 200,
        message: '上传成功',
        data: null,
        list: null,
      ));
    } else {
      return R.ok(BaseModel(
        code: 500,
        message: '上传类型错误',
        data: type,
        list: null,
      ));
    }
  }

  @Route.get('/list')
  Future<Response> list(Request request) async {
    var list = await ApkMid.getList();
    return R.ok(
      BaseModel(code: 200, message: '', data: null, list: list),
    );
  }
}
