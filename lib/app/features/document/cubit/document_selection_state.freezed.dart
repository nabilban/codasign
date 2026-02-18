// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document_selection_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$DocumentSelectionState {
  bool get isLoading => throw _privateConstructorUsedError;
  DocumentModel? get selectedDocument => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;

  /// Create a copy of DocumentSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentSelectionStateCopyWith<DocumentSelectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentSelectionStateCopyWith<$Res> {
  factory $DocumentSelectionStateCopyWith(
    DocumentSelectionState value,
    $Res Function(DocumentSelectionState) then,
  ) = _$DocumentSelectionStateCopyWithImpl<$Res, DocumentSelectionState>;
  @useResult
  $Res call({
    bool isLoading,
    DocumentModel? selectedDocument,
    Failure? failure,
  });

  $DocumentModelCopyWith<$Res>? get selectedDocument;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$DocumentSelectionStateCopyWithImpl<
  $Res,
  $Val extends DocumentSelectionState
>
    implements $DocumentSelectionStateCopyWith<$Res> {
  _$DocumentSelectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DocumentSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? selectedDocument = freezed,
    Object? failure = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedDocument: freezed == selectedDocument
                ? _value.selectedDocument
                : selectedDocument // ignore: cast_nullable_to_non_nullable
                      as DocumentModel?,
            failure: freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                      as Failure?,
          )
          as $Val,
    );
  }

  /// Create a copy of DocumentSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocumentModelCopyWith<$Res>? get selectedDocument {
    if (_value.selectedDocument == null) {
      return null;
    }

    return $DocumentModelCopyWith<$Res>(_value.selectedDocument!, (value) {
      return _then(_value.copyWith(selectedDocument: value) as $Val);
    });
  }

  /// Create a copy of DocumentSelectionState
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
abstract class _$$DocumentSelectionStateImplCopyWith<$Res>
    implements $DocumentSelectionStateCopyWith<$Res> {
  factory _$$DocumentSelectionStateImplCopyWith(
    _$DocumentSelectionStateImpl value,
    $Res Function(_$DocumentSelectionStateImpl) then,
  ) = __$$DocumentSelectionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    DocumentModel? selectedDocument,
    Failure? failure,
  });

  @override
  $DocumentModelCopyWith<$Res>? get selectedDocument;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$DocumentSelectionStateImplCopyWithImpl<$Res>
    extends
        _$DocumentSelectionStateCopyWithImpl<$Res, _$DocumentSelectionStateImpl>
    implements _$$DocumentSelectionStateImplCopyWith<$Res> {
  __$$DocumentSelectionStateImplCopyWithImpl(
    _$DocumentSelectionStateImpl _value,
    $Res Function(_$DocumentSelectionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DocumentSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? selectedDocument = freezed,
    Object? failure = freezed,
  }) {
    return _then(
      _$DocumentSelectionStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedDocument: freezed == selectedDocument
            ? _value.selectedDocument
            : selectedDocument // ignore: cast_nullable_to_non_nullable
                  as DocumentModel?,
        failure: freezed == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure?,
      ),
    );
  }
}

/// @nodoc

class _$DocumentSelectionStateImpl implements _DocumentSelectionState {
  const _$DocumentSelectionStateImpl({
    this.isLoading = false,
    this.selectedDocument,
    this.failure,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final DocumentModel? selectedDocument;
  @override
  final Failure? failure;

  @override
  String toString() {
    return 'DocumentSelectionState(isLoading: $isLoading, selectedDocument: $selectedDocument, failure: $failure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentSelectionStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.selectedDocument, selectedDocument) ||
                other.selectedDocument == selectedDocument) &&
            (identical(other.failure, failure) || other.failure == failure));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, selectedDocument, failure);

  /// Create a copy of DocumentSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentSelectionStateImplCopyWith<_$DocumentSelectionStateImpl>
  get copyWith =>
      __$$DocumentSelectionStateImplCopyWithImpl<_$DocumentSelectionStateImpl>(
        this,
        _$identity,
      );
}

abstract class _DocumentSelectionState implements DocumentSelectionState {
  const factory _DocumentSelectionState({
    final bool isLoading,
    final DocumentModel? selectedDocument,
    final Failure? failure,
  }) = _$DocumentSelectionStateImpl;

  @override
  bool get isLoading;
  @override
  DocumentModel? get selectedDocument;
  @override
  Failure? get failure;

  /// Create a copy of DocumentSelectionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentSelectionStateImplCopyWith<_$DocumentSelectionStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
