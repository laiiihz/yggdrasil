import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../custom_response.dart';
import '../models/base_model.dart';
import '../utils/file_util.dart';

part 'common_services.g.dart';

class CommonServices {
  Router get router => _$CommonServicesRouter(this);
  @Route.post('/avatar')
  Future<Response> uploadAvatar(Request request) async {
    var raw = await request.read().toList();
    var binary = <int>[];
    for (var item in raw) {
      binary.addAll(item);
    }
    final contentType = request.headers['Content-Type'] ?? '';
    var extension = extensionFromMime(contentType);
    String name = await FileUtil.storeAvatar(binary, extension);
    return R.ok(BaseModel(code: 200, message: '', data: name, list: null));
  }

  @Route.get('/avatar/<name>')
  Future<Response> avatar(Request request, String name) async {
    var mime = lookupMimeType(name);
    var binary = await FileUtil.getAvatar(name);
    if (binary == null) return Response.notFound('');
    return Response.ok(
      binary,
      headers: {'content-type': mime ?? 'application/octet-stream'},
    );
  }
}
