import 'dart:convert';

import 'package:shelf/shelf.dart';

Middleware get appInterceptor => (innerHandler) {
      return (request) {
        print(request.url.path);
        if (request.headers['token'] == null &&
            interceptorList.contains(request.url.path)) {
          return Response.ok(json.encode({'code': 100}));
        } else {
          return innerHandler(request);
        }
      };
    };

List<String> interceptorList = ['test'];
