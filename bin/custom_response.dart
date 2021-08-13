import 'dart:convert';

import 'package:shelf/shelf.dart';

class R {
  static Response ok(dynamic object) {
    return Response.ok(
      json.encode(object.toJson()),
      headers: {'content-type': 'application/json'},
    );
  }
}
