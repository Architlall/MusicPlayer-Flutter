// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'albumModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) {
  return AlbumModel(
    title: json['title'] as String,
    cover: json['cover'] as String,
  );
}

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'cover': instance.cover,
    };
