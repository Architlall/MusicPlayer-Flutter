import 'package:json_annotation/json_annotation.dart';
import './albumModel.dart';
import './artistModel.dart';

part 'model.g.dart';

@JsonSerializable()
class Model {
  String title;
  String preview;
  ArtistModel artist;
  AlbumModel album;

  // String xyz;
  Model({this.title, this.preview, this.artist, this.album});
  factory Model.fromJson(Map<String, dynamic> json) => _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);
}
