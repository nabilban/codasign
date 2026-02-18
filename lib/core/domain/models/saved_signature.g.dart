// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_signature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedSignatureImpl _$$SavedSignatureImplFromJson(Map<String, dynamic> json) =>
    _$SavedSignatureImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      filePath: json['filePath'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SavedSignatureImplToJson(
  _$SavedSignatureImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'filePath': instance.filePath,
  'createdAt': instance.createdAt.toIso8601String(),
};
