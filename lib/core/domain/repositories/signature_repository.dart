import 'package:codasign/core/domain/models/failure.dart';
import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:dartz/dartz.dart';

abstract class SignatureRepository {
  Future<Either<Failure, List<SavedSignature>>> readSignatures();
  Future<Either<Failure, SavedSignature>> saveSignature({
    required List<int> bytes,
    required String name,
  });
  Future<Either<Failure, Unit>> removeSignature(String id);
  Future<Either<Failure, Unit>> clearAllSignatures();
}
