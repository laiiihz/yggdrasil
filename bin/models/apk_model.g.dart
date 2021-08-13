// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apk_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APKModel _$APKModelFromJson(Map<String, dynamic> json) {
  return APKModel(
    uuid: json['uuid'] as String,
    name: json['name'] as String?,
    versionCode: json['versionCode'] as String?,
    versionName: json['versionName'] as String?,
    sdkVersion: json['sdkVersion'] as String?,
    targetSdkVersion: json['targetSdkVersion'] as String?,
    usesPermission: (json['usesPermission'] as List<dynamic>)
        .map((e) => e as String)
        .toList(),
  );
}

Map<String, dynamic> _$APKModelToJson(APKModel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'versionCode': instance.versionCode,
      'versionName': instance.versionName,
      'sdkVersion': instance.sdkVersion,
      'targetSdkVersion': instance.targetSdkVersion,
      'usesPermission': instance.usesPermission,
    };
