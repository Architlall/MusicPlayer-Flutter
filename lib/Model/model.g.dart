// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) {
  return Model(
    title: json['title'] as String,
    preview: json['preview'] as String,
  );
}

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'title': instance.title,
      'preview': instance.preview,
    };
