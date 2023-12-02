// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'furniture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FurnitureImpl _$$FurnitureImplFromJson(Map<String, dynamic> json) =>
    _$FurnitureImpl(
      enName: json['enName'] as String,
      jaName: json['jaName'] as String,
      designedYear: json['designedYear'] as int,
      type: $enumDecode(_$FurnitureTypeEnumMap, json['type']),
      designer: Designer.fromJson(json['designer'] as Map<String, dynamic>),
      brand: Brand.fromJson(json['brand'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String,
      memo: json['memo'] as String,
    );

Map<String, dynamic> _$$FurnitureImplToJson(_$FurnitureImpl instance) =>
    <String, dynamic>{
      'enName': instance.enName,
      'jaName': instance.jaName,
      'designedYear': instance.designedYear,
      'type': _$FurnitureTypeEnumMap[instance.type]!,
      'designer': instance.designer,
      'brand': instance.brand,
      'imageUrl': instance.imageUrl,
      'memo': instance.memo,
    };

const _$FurnitureTypeEnumMap = {
  FurnitureType.chair: 'chair',
  FurnitureType.stool: 'stool',
  FurnitureType.table: 'table',
  FurnitureType.sofa: 'sofa',
  FurnitureType.bench: 'bench',
  FurnitureType.light: 'light',
  FurnitureType.mirror: 'mirror',
  FurnitureType.bed: 'bed',
  FurnitureType.shelf: 'shelf',
  FurnitureType.rug: 'rug',
  FurnitureType.desk: 'desk',
  FurnitureType.other: 'other',
};
