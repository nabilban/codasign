import 'package:codasign/core/data/datasources/signature_local_datasource.dart';
import 'package:codasign/core/domain/models/failure.dart';
import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:codasign/core/domain/repositories/signature_repository.dart';
import 'package:dartz/dartz.dart';

class SignatureRepositoryImpl implements SignatureRepository {
  SignatureRepositoryImpl({required this.datasource});

  final SignatureLocalDatasource datasource;

  @override
  Future<Either<Failure, List<SavedSignature>>> readSignatures() async {
    try {
      final results = await datasource.loadSignatures();
      return Right(results);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SavedSignature>> saveSignature({
    required List<int> bytes,
    required String name,
  }) async {
    try {
      final result = await datasource.saveSignature(
        pngBytes: bytes,
        name: name,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeSignature(String id) async {
    try {
      await datasource.deleteSignature(id);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAllSignatures() async {
    try {
      await datasource.deleteAllSignatures();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }
}
