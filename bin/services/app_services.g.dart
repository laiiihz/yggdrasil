// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_services.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AppServicesRouter(AppServices service) {
  final router = Router();
  router.add('PUT', r'/apps', service.setApp);
  router.add('GET', r'/apps', service.apps);
  router.add('PUT', r'/channel', service.setChannel);
  router.add('POST', r'/upload', service.upload);
  router.add('GET', r'/list', service.list);
  return router;
}
