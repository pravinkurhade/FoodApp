import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu {
  Menu({
    this.$oid,
    this.name,
    this.description,
    this.price,
    this.image,
  });

  dynamic $oid;
  dynamic name;
  dynamic description;
  dynamic price;
  dynamic image;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}