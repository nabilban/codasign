// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_signatures_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SavedSignaturesState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<SavedSignature> get signatures => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  /// Create a copy of SavedSignaturesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedSignaturesStateCopyWith<SavedSignaturesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedSignaturesStateCopyWith<$Res> {
  factory $SavedSignaturesStateCopyWith(
    SavedSignaturesState value,
    $Res Function(SavedSignaturesState) then,
  ) = _$SavedSignaturesStateCopyWithImpl<$Res, SavedSignaturesState>;
  @useResult
  $Res call({
    bool isLoading,
    List<SavedSignature> signatures,
    Failure? failure,
  });

  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$SavedSignaturesStateCopyWithImpl<
  $Res,
  $Val extends SavedSignaturesState
>
    implements $SavedSignaturesStateCopyWith<$Res> {
  _$SavedSignaturesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedSignaturesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? signatures = null,
    Object? failure = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            signatures: null == signatures
                ? _value.signatures
                : signatures // ignore: cast_nullable_to_non_nullable
                      as List<SavedSignature>,
            failure: freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                      as Failure?,
          )
          as $Val,
    );
  }

  /// Create a copy of SavedSignaturesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get failure {
    if (_value.failure == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.failure!, (value) {
      return _then(_value.copyWith(failure: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedSignaturesStateImplCopyWith<$Res>
    implements $SavedSignaturesStateCopyWith<$Res> {
  factory _$$SavedSignaturesStateImplCopyWith(
    _$SavedSignaturesStateImpl value,
    $Res Function(_$SavedSignaturesStateImpl) then,
  ) = __$$SavedSignaturesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    List<SavedSignature> signatures,
    Failure? failure,
  });

  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$SavedSignaturesStateImplCopyWithImpl<$Res>
    extends _$SavedSignaturesStateCopyWithImpl<$Res, _$SavedSignaturesStateImpl>
    implements _$$SavedSignaturesStateImplCopyWith<$Res> {
  __$$SavedSignaturesStateImplCopyWithImpl(
    _$SavedSignaturesStateImpl _value,
    $Res Function(_$SavedSignaturesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedSignaturesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? signatures = null,
    Object? failure = freezed,
  }) {
    return _then(
      _$SavedSignaturesStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        signatures: null == signatures
            ? _value._signatures
            : signatures // ignore: cast_nullable_to_non_nullable
                  as List<SavedSignature>,
        failure: freezed == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure?,
      ),
    );
  }
}

/// @nodoc

class _$SavedSignaturesStateImpl implements _SavedSignaturesState {
  const _$SavedSignaturesStateImpl({
    this.isLoading = false,
    final List<SavedSignature> signatures = const [],
    this.failure,
  }) : _signatures = signatures;

  @override
  @JsonKey()
  final bool isLoading;
  final List<SavedSignature> _signatures;
  @override
  @JsonKey()
  List<SavedSignature> get signatures {
    if (_signatures is EqualUnmodifiableListView) return _signatures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_signatures);
  }

  @override
  final Failure? failure;

  @override
  String toString() {
    return 'SavedSignaturesState(isLoading: $isLoading, signatures: $signatures, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedSignaturesStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(
              other._signatures,
              _signatures,
            ) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_signatures),
    failure,
  );

  /// Create a copy of SavedSignaturesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedSignaturesStateImplCopyWith<_$SavedSignaturesStateImpl>
  get copyWith =>
      __$$SavedSignaturesStateImplCopyWithImpl<_$SavedSignaturesStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SavedSignaturesState implements SavedSignaturesState {
  const factory _SavedSignaturesState({
    final bool isLoading,
    final List<SavedSignature> signatures,
    final Failure? failure,
  }) = _$SavedSignaturesStateImpl;

  @override
  bool get isLoading;
  @override
  List<SavedSignature> get signatures;
  @override
  Failure? get failure;

  /// Create a copy of SavedSignaturesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedSignaturesStateImplCopyWith<_$SavedSignaturesStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
