// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Model _$ModelFromJson(Map<String, dynamic> json) {
  return Model(
    title: json['title'] as String,
    preview: json['preview'] as String,
    artist: json['artist'] == null
        ? null
        : ArtistModel.fromJson(json['artist'] as Map<String, dynamic>),
    album: json['album'] == null
        ? null
        : AlbumModel.fromJson(json['album'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ModelToJson(Model instance) => <String, dynamic>{
      'title': instance.title,
      'preview': instance.preview,
      'artist': instance.artist,
      'album': instance.album,
    };
