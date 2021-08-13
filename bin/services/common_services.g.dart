// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_services.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$CommonServicesRouter(CommonServices service) {
  final router = Router();
  router.add('POST', r'/avatar', service.uploadAvatar);
  router.add('GET', r'/avatar/<name>', service.avatar);
  return router;
}
