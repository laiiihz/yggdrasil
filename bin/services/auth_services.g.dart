// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_services.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthServicesRouter(AuthServices service) {
  final router = Router();
  router.add('POST', r'/login', service.login);
  router.add('POST', r'/signUp', service.signUp);
  return router;
}
