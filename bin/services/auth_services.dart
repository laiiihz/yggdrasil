import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';

import '../custom_response.dart';
import '../midware/user_midware.dart';
import '../models/auth/user_model.dart';
import '../models/base_model.dart';
import '../utils/db_util.dart';

part 'auth_services.g.dart';

class AuthServices {
  Router get router => _$AuthServicesRouter(this);

  @Route.post('/login')
  Future<Response> login(Request request) async {
    var body = await request.readAsString();
    Map<String, dynamic> map = json.decode(body);
    String phone = map['phone'];
    var model = await UserMid.getUserByPhone(phone);
    if (model == null) {
      return R.ok(BaseModel(
        code: 10000,
        message: '账号或密码错误',
        data: null,
        list: null,
      ));
    } else if (model.password == map['password']) {
      var token = Uuid().v4();
      await DB.command.set(token, model.uuid);
      await DB.command.send_object(['expire', token, 2000]);

      return R.ok(
        BaseModel(
          code: 200,
          message: '登录成功',
          data: {'token': token},
          list: null,
        ),
      );
    }
    return R.ok(BaseModel(
      code: 10000,
      message: '账号或密码错误',
      data: null,
      list: null,
    ));
  }

  @Route.post('/signUp')
  Future<Response> signUp(Request request) async {
    var body = await request.readAsString();
    Map<String, dynamic> model = json.decode(body);
    var userModel = await UserMid.getUserByPhone(model['phone']);
    if (userModel == null) {
      await UserMid.addUser(UserModel(
        uuid: Uuid().v4(),
        nickname: model['nickname'],
        password: model['password'],
        role: UserRole.visitor,
        phone: model['phone'],
        email: model['email'],
      ));
      return R.ok(
        BaseModel(code: 200, message: '注册成功', data: {}, list: null),
      );
    }
    return R.ok(BaseModel(
      code: 500,
      message: '该账号已经注册',
      data: null,
      list: null,
    ));
  }
}
