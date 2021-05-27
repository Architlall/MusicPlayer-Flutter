// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artistModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistModel _$ArtistModelFromJson(Map<String, dynamic> json) {
  return ArtistModel(
    name: json['name'] as String,
    picture: json['picture'] as String,
  );
}

Map<String, dynamic> _$ArtistModelToJson(ArtistModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'picture': instance.picture,
    };
