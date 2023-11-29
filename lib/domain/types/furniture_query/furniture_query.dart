import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'furniture_query.freezed.dart';

@freezed
class FurnitureQuery with _$FurnitureQuery {
  const factory FurnitureQuery({
    required String property,
    required List<String> targets,
  }) = _FurnitureQuery;
}