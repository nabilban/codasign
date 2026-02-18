// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signature_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SignatureState {
  Color get penColor => throw _privateConstructorUsedError;
  double get penStrokeWidth => throw _privateConstructorUsedError;
  bool get isDrawing => throw _privateConstructorUsedError;

  /// Create a copy of SignatureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignatureStateCopyWith<SignatureState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignatureStateCopyWith<$Res> {
  factory $SignatureStateCopyWith(
    SignatureState value,
    $Res Function(SignatureState) then,
  ) = _$SignatureStateCopyWithImpl<$Res, SignatureState>;
  @useResult
  $Res call({Color penColor, double penStrokeWidth, bool isDrawing});
}

/// @nodoc
class _$SignatureStateCopyWithImpl<$Res, $Val extends SignatureState>
    implements $SignatureStateCopyWith<$Res> {
  _$SignatureStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignatureState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? penColor = null,
    Object? penStrokeWidth = null,
    Object? isDrawing = null,
  }) {
    return _then(
      _value.copyWith(
            penColor: null == penColor
                ? _value.penColor
                : penColor // ignore: cast_nullable_to_non_nullable
                      as Color,
            penStrokeWidth: null == penStrokeWidth
                ? _value.penStrokeWidth
                : penStrokeWidth // ignore: cast_nullable_to_non_nullable
                      as double,
            isDrawing: null == isDrawing
                ? _value.isDrawing
                : isDrawing // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SignatureStateImplCopyWith<$Res>
    implements $SignatureStateCopyWith<$Res> {
  factory _$$SignatureStateImplCopyWith(
    _$SignatureStateImpl value,
    $Res Function(_$SignatureStateImpl) then,
  ) = __$$SignatureStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Color penColor, double penStrokeWidth, bool isDrawing});
}

/// @nodoc
class __$$SignatureStateImplCopyWithImpl<$Res>
    extends _$SignatureStateCopyWithImpl<$Res, _$SignatureStateImpl>
    implements _$$SignatureStateImplCopyWith<$Res> {
  __$$SignatureStateImplCopyWithImpl(
    _$SignatureStateImpl _value,
    $Res Function(_$SignatureStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignatureState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? penColor = null,
    Object? penStrokeWidth = null,
    Object? isDrawing = null,
  }) {
    return _then(
      _$SignatureStateImpl(
        penColor: null == penColor
            ? _value.penColor
            : penColor // ignore: cast_nullable_to_non_nullable
                  as Color,
        penStrokeWidth: null == penStrokeWidth
            ? _value.penStrokeWidth
            : penStrokeWidth // ignore: cast_nullable_to_non_nullable
                  as double,
        isDrawing: null == isDrawing
            ? _value.isDrawing
            : isDrawing // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$SignatureStateImpl implements _SignatureState {
  const _$SignatureStateImpl({
    this.penColor = Colors.black,
    this.penStrokeWidth = 3.0,
    this.isDrawing = false,
  });

  @override
  @JsonKey()
  final Color penColor;
  @override
  @JsonKey()
  final double penStrokeWidth;
  @override
  @JsonKey()
  final bool isDrawing;

  @override
  String toString() {
    return 'SignatureState(penColor: $penColor, penStrokeWidth: $penStrokeWidth, isDrawing: $isDrawing)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignatureStateImpl &&
            (identical(other.penColor, penColor) ||
                other.penColor == penColor) &&
            (identical(other.penStrokeWidth, penStrokeWidth) ||
                other.penStrokeWidth == penStrokeWidth) &&
            (identical(other.isDrawing, isDrawing) ||
                other.isDrawing == isDrawing));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, penColor, penStrokeWidth, isDrawing);

  /// Create a copy of SignatureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignatureStateImplCopyWith<_$SignatureStateImpl> get copyWith =>
      __$$SignatureStateImplCopyWithImpl<_$SignatureStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SignatureState implements SignatureState {
  const factory _SignatureState({
    final Color penColor,
    final double penStrokeWidth,
    final bool isDrawing,
  }) = _$SignatureStateImpl;

  @override
  Color get penColor;
  @override
  double get penStrokeWidth;
  @override
  bool get isDrawing;

  /// Create a copy of SignatureState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignatureStateImplCopyWith<_$SignatureStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
