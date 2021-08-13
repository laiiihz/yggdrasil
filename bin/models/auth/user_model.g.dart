// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    uuid: json['uuid'] as String,
    nickname: json['nickname'] as String?,
    password: json['password'] as String,
    role: _$enumDecode(_$UserRoleEnumMap, json['role']),
    phone: json['phone'] as String?,
    email: json['email'] as String?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'nickname': instance.nickname,
      'password': instance.password,
      'role': _$UserRoleEnumMap[instance.role],
      'phone': instance.phone,
      'email': instance.email,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$UserRoleEnumMap = {
  UserRole.administrator: 'administrator',
  UserRole.develop: 'develop',
  UserRole.visitor: 'visitor',
  UserRole.none: 'none',
};
