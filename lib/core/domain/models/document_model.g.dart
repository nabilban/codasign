// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentModelImpl _$$DocumentModelImplFromJson(Map<String, dynamic> json) =>
    _$DocumentModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      path: json['path'] as String,
      size: (json['size'] as num).toInt(),
      pageCount: (json['pageCount'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$DocumentModelImplToJson(_$DocumentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'path': instance.path,
      'size': instance.size,
      'pageCount': instance.pageCount,
      'createdAt': instance.createdAt.toIso8601String(),
    };
