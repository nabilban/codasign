import 'package:codasign/core/domain/models/failure.dart';
import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_signatures_state.freezed.dart';

@freezed
class SavedSignaturesState with _$SavedSignaturesState {
  const factory SavedSignaturesState({
    @Default(false) bool isLoading,
    @Default([]) List<SavedSignature> signatures,
    Failure? failure,
  }) = _SavedSignaturesState;
}
