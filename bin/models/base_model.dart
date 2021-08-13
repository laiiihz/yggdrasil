import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  final int code;
  final String message;
  final dynamic data;
  final List<dynamic>? list;
  BaseModel({
    required this.code,
    required this.message,
    required this.data,
    required this.list,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
