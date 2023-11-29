// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'furniture_query.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$FurnitureQuery {
  String get property => throw _privateConstructorUsedError;
  List<String> get targets => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FurnitureQueryCopyWith<FurnitureQuery> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FurnitureQueryCopyWith<$Res> {
  factory $FurnitureQueryCopyWith(
          FurnitureQuery value, $Res Function(FurnitureQuery) then) =
      _$FurnitureQueryCopyWithImpl<$Res, FurnitureQuery>;
  @useResult
  $Res call({String property, List<String> targets});
}

/// @nodoc
class _$FurnitureQueryCopyWithImpl<$Res, $Val extends FurnitureQuery>
    implements $FurnitureQueryCopyWith<$Res> {
  _$FurnitureQueryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? property = null,
    Object? targets = null,
  }) {
    return _then(_value.copyWith(
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as String,
      targets: null == targets
          ? _value.targets
          : targets // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FurnitureQueryImplCopyWith<$Res>
    implements $FurnitureQueryCopyWith<$Res> {
  factory _$$FurnitureQueryImplCopyWith(_$FurnitureQueryImpl value,
          $Res Function(_$FurnitureQueryImpl) then) =
      __$$FurnitureQueryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String property, List<String> targets});
}

/// @nodoc
class __$$FurnitureQueryImplCopyWithImpl<$Res>
    extends _$FurnitureQueryCopyWithImpl<$Res, _$FurnitureQueryImpl>
    implements _$$FurnitureQueryImplCopyWith<$Res> {
  __$$FurnitureQueryImplCopyWithImpl(
      _$FurnitureQueryImpl _value, $Res Function(_$FurnitureQueryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? property = null,
    Object? targets = null,
  }) {
    return _then(_$FurnitureQueryImpl(
      property: null == property
          ? _value.property
          : property // ignore: cast_nullable_to_non_nullable
              as String,
      targets: null == targets
          ? _value._targets
          : targets // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$FurnitureQueryImpl
    with DiagnosticableTreeMixin
    implements _FurnitureQuery {
  const _$FurnitureQueryImpl(
      {required this.property, required final List<String> targets})
      : _targets = targets;

  @override
  final String property;
  final List<String> _targets;
  @override
  List<String> get targets {
    if (_targets is EqualUnmodifiableListView) return _targets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targets);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FurnitureQuery(property: $property, targets: $targets)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FurnitureQuery'))
      ..add(DiagnosticsProperty('property', property))
      ..add(DiagnosticsProperty('targets', targets));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FurnitureQueryImpl &&
            (identical(other.property, property) ||
                other.property == property) &&
            const DeepCollectionEquality().equals(other._targets, _targets));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, property, const DeepCollectionEquality().hash(_targets));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FurnitureQueryImplCopyWith<_$FurnitureQueryImpl> get copyWith =>
      __$$FurnitureQueryImplCopyWithImpl<_$FurnitureQueryImpl>(
          this, _$identity);
}

abstract class _FurnitureQuery implements FurnitureQuery {
  const factory _FurnitureQuery(
      {required final String property,
      required final List<String> targets}) = _$FurnitureQueryImpl;

  @override
  String get property;
  @override
  List<String> get targets;
  @override
  @JsonKey(ignore: true)
  _$$FurnitureQueryImplCopyWith<_$FurnitureQueryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
