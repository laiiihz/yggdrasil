import 'package:shelf_router/shelf_router.dart';
import 'services/app_services.dart';
import 'services/auth_services.dart';
import 'services/common_services.dart';

part 'service.g.dart';

class BaseService {
  @Route.mount('/auth/')
  Router get _auth => AuthServices().router;
  @Route.mount('/app/')
  Router get _app => AppServices().router;
  @Route.mount('/common/')
  Router get _common => CommonServices().router;
  Router get router => _$BaseServiceRouter(this);
}
