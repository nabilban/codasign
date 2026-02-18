// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pdf_signing_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PDFSigningState {
  DocumentModel get document => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  SavedSignature? get selectedSignature => throw _privateConstructorUsedError;
  Offset get signaturePosition => throw _privateConstructorUsedError;
  double get signatureScale => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  bool get saveSuccess => throw _privateConstructorUsedError;

  /// Create a copy of PDFSigningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PDFSigningStateCopyWith<PDFSigningState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PDFSigningStateCopyWith<$Res> {
  factory $PDFSigningStateCopyWith(
    PDFSigningState value,
    $Res Function(PDFSigningState) then,
  ) = _$PDFSigningStateCopyWithImpl<$Res, PDFSigningState>;
  @useResult
  $Res call({
    DocumentModel document,
    bool isSaving,
    SavedSignature? selectedSignature,
    Offset signaturePosition,
    double signatureScale,
    int currentPage,
    Failure? failure,
    bool saveSuccess,
  });

  $DocumentModelCopyWith<$Res> get document;
  $SavedSignatureCopyWith<$Res>? get selectedSignature;
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class _$PDFSigningStateCopyWithImpl<$Res, $Val extends PDFSigningState>
    implements $PDFSigningStateCopyWith<$Res> {
  _$PDFSigningStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PDFSigningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? document = null,
    Object? isSaving = null,
    Object? selectedSignature = freezed,
    Object? signaturePosition = null,
    Object? signatureScale = null,
    Object? currentPage = null,
    Object? failure = freezed,
    Object? saveSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            document: null == document
                ? _value.document
                : document // ignore: cast_nullable_to_non_nullable
                      as DocumentModel,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedSignature: freezed == selectedSignature
                ? _value.selectedSignature
                : selectedSignature // ignore: cast_nullable_to_non_nullable
                      as SavedSignature?,
            signaturePosition: null == signaturePosition
                ? _value.signaturePosition
                : signaturePosition // ignore: cast_nullable_to_non_nullable
                      as Offset,
            signatureScale: null == signatureScale
                ? _value.signatureScale
                : signatureScale // ignore: cast_nullable_to_non_nullable
                      as double,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            failure: freezed == failure
                ? _value.failure
                : failure // ignore: cast_nullable_to_non_nullable
                      as Failure?,
            saveSuccess: null == saveSuccess
                ? _value.saveSuccess
                : saveSuccess // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PDFSigningState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DocumentModelCopyWith<$Res> get document {
    return $DocumentModelCopyWith<$Res>(_value.document, (value) {
      return _then(_value.copyWith(document: value) as $Val);
    });
  }

  /// Create a copy of PDFSigningState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SavedSignatureCopyWith<$Res>? get selectedSignature {
    if (_value.selectedSignature == null) {
      return null;
    }

    return $SavedSignatureCopyWith<$Res>(_value.selectedSignature!, (value) {
      return _then(_value.copyWith(selectedSignature: value) as $Val);
    });
  }

  /// Create a copy of PDFSigningState
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
abstract class _$$PDFSigningStateImplCopyWith<$Res>
    implements $PDFSigningStateCopyWith<$Res> {
  factory _$$PDFSigningStateImplCopyWith(
    _$PDFSigningStateImpl value,
    $Res Function(_$PDFSigningStateImpl) then,
  ) = __$$PDFSigningStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DocumentModel document,
    bool isSaving,
    SavedSignature? selectedSignature,
    Offset signaturePosition,
    double signatureScale,
    int currentPage,
    Failure? failure,
    bool saveSuccess,
  });

  @override
  $DocumentModelCopyWith<$Res> get document;
  @override
  $SavedSignatureCopyWith<$Res>? get selectedSignature;
  @override
  $FailureCopyWith<$Res>? get failure;
}

/// @nodoc
class __$$PDFSigningStateImplCopyWithImpl<$Res>
    extends _$PDFSigningStateCopyWithImpl<$Res, _$PDFSigningStateImpl>
    implements _$$PDFSigningStateImplCopyWith<$Res> {
  __$$PDFSigningStateImplCopyWithImpl(
    _$PDFSigningStateImpl _value,
    $Res Function(_$PDFSigningStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PDFSigningState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? document = null,
    Object? isSaving = null,
    Object? selectedSignature = freezed,
    Object? signaturePosition = null,
    Object? signatureScale = null,
    Object? currentPage = null,
    Object? failure = freezed,
    Object? saveSuccess = null,
  }) {
    return _then(
      _$PDFSigningStateImpl(
        document: null == document
            ? _value.document
            : document // ignore: cast_nullable_to_non_nullable
                  as DocumentModel,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedSignature: freezed == selectedSignature
            ? _value.selectedSignature
            : selectedSignature // ignore: cast_nullable_to_non_nullable
                  as SavedSignature?,
        signaturePosition: null == signaturePosition
            ? _value.signaturePosition
            : signaturePosition // ignore: cast_nullable_to_non_nullable
                  as Offset,
        signatureScale: null == signatureScale
            ? _value.signatureScale
            : signatureScale // ignore: cast_nullable_to_non_nullable
                  as double,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        failure: freezed == failure
            ? _value.failure
            : failure // ignore: cast_nullable_to_non_nullable
                  as Failure?,
        saveSuccess: null == saveSuccess
            ? _value.saveSuccess
            : saveSuccess // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$PDFSigningStateImpl implements _PDFSigningState {
  const _$PDFSigningStateImpl({
    required this.document,
    this.isSaving = false,
    this.selectedSignature,
    this.signaturePosition = const Offset(100, 100),
    this.signatureScale = 1.0,
    this.currentPage = 1,
    this.failure,
    this.saveSuccess = false,
  });

  @override
  final DocumentModel document;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final SavedSignature? selectedSignature;
  @override
  @JsonKey()
  final Offset signaturePosition;
  @override
  @JsonKey()
  final double signatureScale;
  @override
  @JsonKey()
  final int currentPage;
  @override
  final Failure? failure;
  @override
  @JsonKey()
  final bool saveSuccess;

  @override
  String toString() {
    return 'PDFSigningState(document: $document, isSaving: $isSaving, selectedSignature: $selectedSignature, signaturePosition: $signaturePosition, signatureScale: $signatureScale, currentPage: $currentPage, failure: $failure, saveSuccess: $saveSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PDFSigningStateImpl &&
            (identical(other.document, document) ||
                other.document == document) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.selectedSignature, selectedSignature) ||
                other.selectedSignature == selectedSignature) &&
            (identical(other.signaturePosition, signaturePosition) ||
                other.signaturePosition == signaturePosition) &&
            (identical(other.signatureScale, signatureScale) ||
                other.signatureScale == signatureScale) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.saveSuccess, saveSuccess) ||
                other.saveSuccess == saveSuccess));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    document,
    isSaving,
    selectedSignature,
    signaturePosition,
    signatureScale,
    currentPage,
    failure,
    saveSuccess,
  );

  /// Create a copy of PDFSigningState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PDFSigningStateImplCopyWith<_$PDFSigningStateImpl> get copyWith =>
      __$$PDFSigningStateImplCopyWithImpl<_$PDFSigningStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PDFSigningState implements PDFSigningState {
  const factory _PDFSigningState({
    required final DocumentModel document,
    final bool isSaving,
    final SavedSignature? selectedSignature,
    final Offset signaturePosition,
    final double signatureScale,
    final int currentPage,
    final Failure? failure,
    final bool saveSuccess,
  }) = _$PDFSigningStateImpl;

  @override
  DocumentModel get document;
  @override
  bool get isSaving;
  @override
  SavedSignature? get selectedSignature;
  @override
  Offset get signaturePosition;
  @override
  double get signatureScale;
  @override
  int get currentPage;
  @override
  Failure? get failure;
  @override
  bool get saveSuccess;

  /// Create a copy of PDFSigningState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PDFSigningStateImplCopyWith<_$PDFSigningStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
