// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      $oid: json[r'$oid'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      r'$oid': instance.$oid,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
    };
