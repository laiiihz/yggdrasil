import 'package:json_annotation/json_annotation.dart';

part 'apk_model.g.dart';

@JsonSerializable()
class APKModel {
  String uuid;
  String? name;
  String? versionCode;
  String? versionName;
  String? sdkVersion;
  String? targetSdkVersion;
  List<String> usesPermission;
  APKModel({
    required this.uuid,
    this.name,
    this.versionCode,
    this.versionName,
    this.sdkVersion,
    this.targetSdkVersion,
    required this.usesPermission,
  });

  factory APKModel.fromJson(Map<String, dynamic> json) =>
      _$APKModelFromJson(json);
  Map<String, dynamic> toJson() => _$APKModelToJson(this);
}
