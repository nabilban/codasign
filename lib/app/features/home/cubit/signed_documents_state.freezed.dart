// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signed_documents_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SignedDocumentsState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<DocumentModel> get documents => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  /// Create a copy of SignedDocumentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SignedDocumentsStateCopyWith<SignedDocumentsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignedDocumentsStateCopyWith<$Res> {
  factory $SignedDocumentsStateCopyWith(
    SignedDocumentsState value,
    $Res Function(SignedDocumentsState) then,
  ) = _$SignedDocumentsStateCopyWithImpl<$Res, SignedDocumentsState>;
  @useResult
  $Res call({bool isLoading, List<DocumentModel> documents, Failure? failure});

  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$SignedDocumentsStateCopyWithImpl<
  $Res,
  $Val extends SignedDocumentsState
>
    implements $SignedDocumentsStateCopyWith<$Res> {
  _$SignedDocumentsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SignedDocumentsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? documents = null,
    Object? failure = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            documents: null == documents
                ? _value.documents
                : documents // ignore: cast_nullable_to_non_nullable
                      as List<DocumentModel>,
            failure: freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                      as Failure?,
          )
          as $Val,
    );
  }

  /// Create a copy of SignedDocumentsState
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
abstract class _$$SignedDocumentsStateImplCopyWith<$Res>
    implements $SignedDocumentsStateCopyWith<$Res> {
  factory _$$SignedDocumentsStateImplCopyWith(
    _$SignedDocumentsStateImpl value,
    $Res Function(_$SignedDocumentsStateImpl) then,
  ) = __$$SignedDocumentsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<DocumentModel> documents, Failure? failure});

  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$SignedDocumentsStateImplCopyWithImpl<$Res>
    extends _$SignedDocumentsStateCopyWithImpl<$Res, _$SignedDocumentsStateImpl>
    implements _$$SignedDocumentsStateImplCopyWith<$Res> {
  __$$SignedDocumentsStateImplCopyWithImpl(
    _$SignedDocumentsStateImpl _value,
    $Res Function(_$SignedDocumentsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SignedDocumentsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? documents = null,
    Object? failure = freezed,
  }) {
    return _then(
      _$SignedDocumentsStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        documents: null == documents
            ? _value._documents
            : documents // ignore: cast_nullable_to_non_nullable
                  as List<DocumentModel>,
        failure: freezed == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure?,
      ),
    );
  }
}

/// @nodoc

class _$SignedDocumentsStateImpl implements _SignedDocumentsState {
  const _$SignedDocumentsStateImpl({
    this.isLoading = true,
    final List<DocumentModel> documents = const [],
    this.failure,
  }) : _documents = documents;

  @override
  @JsonKey()
  final bool isLoading;
  final List<DocumentModel> _documents;
  @override
  @JsonKey()
  List<DocumentModel> get documents {
    if (_documents is EqualUnmodifiableListView) return _documents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documents);
  }

  @override
  final Failure? failure;

  @override
  String toString() {
    return 'SignedDocumentsState(isLoading: $isLoading, documents: $documents, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignedDocumentsStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(
              other._documents,
              _documents,
            ) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    const DeepCollectionEquality().hash(_documents),
    failure,
  );

  /// Create a copy of SignedDocumentsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SignedDocumentsStateImplCopyWith<_$SignedDocumentsStateImpl>
  get copyWith =>
      __$$SignedDocumentsStateImplCopyWithImpl<_$SignedDocumentsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _SignedDocumentsState implements SignedDocumentsState {
  const factory _SignedDocumentsState({
    final bool isLoading,
    final List<DocumentModel> documents,
    final Failure? failure,
  }) = _$SignedDocumentsStateImpl;

  @override
  bool get isLoading;
  @override
  List<DocumentModel> get documents;
  @override
  Failure? get failure;

  /// Create a copy of SignedDocumentsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SignedDocumentsStateImplCopyWith<_$SignedDocumentsStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
