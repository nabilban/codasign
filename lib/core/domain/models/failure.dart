import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.database({required String message}) = DatabaseFailure;
  const factory Failure.network({required String message}) = NetworkFailure;
  const factory Failure.notFound({required String message}) = NotFoundFailure;
  const factory Failure.unknown({required String message}) = UnknownFailure;
}
