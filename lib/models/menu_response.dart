import 'package:json_annotation/json_annotation.dart';

import 'menu.dart';

part 'menu_response.g.dart';

@JsonSerializable()
class MenuResponse {
  MenuResponse({
    required this.menu,
  });

  List<Menu> menu;

  factory MenuResponse.fromJson(Map<String, dynamic> json) => _$MenuResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MenuResponseToJson(this);
}
