import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_signature.freezed.dart';
part 'saved_signature.g.dart';

@freezed
class SavedSignature with _$SavedSignature {
  const factory SavedSignature({
    required String id,
    required String name,
    required String filePath,
    required DateTime createdAt,
  }) = _SavedSignature;

  factory SavedSignature.fromJson(Map<String, dynamic> json) =>
      _$SavedSignatureFromJson(json);
}
