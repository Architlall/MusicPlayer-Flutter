import 'package:json_annotation/json_annotation.dart';

part 'artistModel.g.dart';

@JsonSerializable()
class ArtistModel {
  String name;
  String picture;

  ArtistModel({this.name, this.picture});
  factory ArtistModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistModelFromJson(json);
  Map<String, dynamic> toJson() => _$ArtistModelToJson(this);
}
