import 'package:json_annotation/json_annotation.dart';

part 'albumModel.g.dart';

@JsonSerializable()
class AlbumModel {
  String title;
  String cover;
  String cover_big;

  AlbumModel({this.title, this.cover, this.cover_big});
  factory AlbumModel.fromJson(Map<String, dynamic> json) =>
      _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}
