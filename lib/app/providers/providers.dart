import 'package:codasign/core/data/datasources/document_local_datasource.dart';
import 'package:codasign/core/data/datasources/signature_local_datasource.dart';
import 'package:codasign/core/data/repositories/document_repository_impl.dart';
import 'package:codasign/core/data/repositories/signature_repository_impl.dart';
import 'package:codasign/core/data/services/pdf_merging_service.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:codasign/core/domain/repositories/signature_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupProviders() {
  getIt
    ..registerLazySingleton<SignatureLocalDatasource>(
      SignatureLocalDatasource.new,
    )
    ..registerLazySingleton<DocumentLocalDatasource>(
      DocumentLocalDatasource.new,
    )
    ..registerLazySingleton<PdfMergingService>(
      PdfMergingService.new,
    )
    ..registerLazySingleton<SignatureRepository>(
      () => SignatureRepositoryImpl(datasource: getIt()),
    )
    ..registerLazySingleton<DocumentRepository>(
      () => DocumentRepositoryImpl(datasource: getIt()),
    );
}
