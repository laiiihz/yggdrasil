// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$BaseServiceRouter(BaseService service) {
  final router = Router();
  router.mount(r'/auth/', service._auth);
  router.mount(r'/app/', service._app);
  router.mount(r'/common/', service._common);
  return router;
}
