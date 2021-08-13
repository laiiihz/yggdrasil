import '../models/auth/user_model.dart';
import '../utils/db_util.dart';
import '../utils/postgres_helper.dart';

class UserMid {
  static Future addUser(UserModel model) async {
    await PostgresHelper.insert('user_t', {
      'uuid': model.uuid,
      'phone': model.phone,
      'nickname': model.nickname,
      'email': model.email,
      'password': model.password,
      'role': model.role.string(),
    });
  }

  static Future<UserModel?> getUserByUuid(String uuid) async {
    var result = await DB.connection.query(
      'select * from user_t where uuid = @uuid',
      substitutionValues: {'uuid': uuid},
    );
    if (result.isEmpty) return null;
    var item = result.first;
    return UserModel(
      uuid: item[0],
      nickname: item[2],
      password: item[4],
      role: UserRoleP.parse(item[5] ?? ''),
      phone: item[1],
      email: item[3],
    );
  }

  static Future<UserModel?> getUserByPhone(String phone) async {
    var result = await DB.connection.query(
      'select * from user_t where phone = @phone',
      substitutionValues: {'phone': phone},
    );
    if (result.isEmpty) return null;
    var item = result.first;
    return UserModel(
      uuid: item[0],
      nickname: item[2],
      password: item[4],
      role: UserRoleP.parse(item[5] ?? ''),
      phone: item[1],
      email: item[3],
    );
  }
}
