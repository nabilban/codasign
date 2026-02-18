// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_signature.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

SavedSignature _$SavedSignatureFromJson(Map<String, dynamic> json) {
  return _SavedSignature.fromJson(json);
}

/// @nodoc
mixin _$SavedSignature {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SavedSignature to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedSignatureCopyWith<SavedSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedSignatureCopyWith<$Res> {
  factory $SavedSignatureCopyWith(
    SavedSignature value,
    $Res Function(SavedSignature) then,
  ) = _$SavedSignatureCopyWithImpl<$Res, SavedSignature>;
  @useResult
  $Res call({String id, String name, String filePath, DateTime createdAt});
}

/// @nodoc
class _$SavedSignatureCopyWithImpl<$Res, $Val extends SavedSignature>
    implements $SavedSignatureCopyWith<$Res> {
  _$SavedSignatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SavedSignatureImplCopyWith<$Res>
    implements $SavedSignatureCopyWith<$Res> {
  factory _$$SavedSignatureImplCopyWith(
    _$SavedSignatureImpl value,
    $Res Function(_$SavedSignatureImpl) then,
  ) = __$$SavedSignatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String filePath, DateTime createdAt});
}

/// @nodoc
class __$$SavedSignatureImplCopyWithImpl<$Res>
    extends _$SavedSignatureCopyWithImpl<$Res, _$SavedSignatureImpl>
    implements _$$SavedSignatureImplCopyWith<$Res> {
  __$$SavedSignatureImplCopyWithImpl(
    _$SavedSignatureImpl _value,
    $Res Function(_$SavedSignatureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedSignature
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? filePath = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$SavedSignatureImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedSignatureImpl implements _SavedSignature {
  const _$SavedSignatureImpl({
    required this.id,
    required this.name,
    required this.filePath,
    required this.createdAt,
  });

  factory _$SavedSignatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedSignatureImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String filePath;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SavedSignature(id: $id, name: $name, filePath: $filePath, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedSignatureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, filePath, createdAt);

  /// Create a copy of SavedSignature
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedSignatureImplCopyWith<_$SavedSignatureImpl> get copyWith =>
      __$$SavedSignatureImplCopyWithImpl<_$SavedSignatureImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedSignatureImplToJson(this);
  }
}

abstract class _SavedSignature implements SavedSignature {
  const factory _SavedSignature({
    required final String id,
    required final String name,
    required final String filePath,
    required final DateTime createdAt,
  }) = _$SavedSignatureImpl;

  factory _SavedSignature.fromJson(Map<String, dynamic> json) =
      _$SavedSignatureImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get filePath;
  @override
  DateTime get createdAt;

  /// Create a copy of SavedSignature
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedSignatureImplCopyWith<_$SavedSignatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
