import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:furniture/infrastructure/firebase/data_path.dart';

export 'package:furniture/domain/types/enum/collection.dart';

part 'db_query.freezed.dart';

@freezed
class DbQuery with _$DbQuery {
  const factory DbQuery({
    required String collection,

    required String property,
    required List<String> targets,
    int? limit,
  }) = _DbQuery;
}