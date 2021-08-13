import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum UserRole {
  administrator,
  develop,
  visitor,
  none,
}

class UserRoleP {
  static UserRole parse(String role) {
    return _$enumDecode(_$UserRoleEnumMap, role);
  }
}

extension UserRoleExt on UserRole {
  String string() {
    return _$UserRoleEnumMap[this] ?? '';
  }
}

@JsonSerializable()
class UserModel {
  final String uuid;
  final String? nickname;

  ///HMAC hash
  final String password;
  final UserRole role;
  final String? phone;
  final String? email;
  UserModel({
    required this.uuid,
    required this.nickname,
    required this.password,
    required this.role,
    required this.phone,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
