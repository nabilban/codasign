import 'package:codasign/core/data/datasources/signature_local_datasource.dart';
import 'package:codasign/core/data/repositories/signature_repository_impl.dart';
import 'package:codasign/core/domain/repositories/signature_repository.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupProviders() {
  getIt
    ..registerLazySingleton<SignatureLocalDatasource>(
      SignatureLocalDatasource.new,
    )
    ..registerLazySingleton<SignatureRepository>(
      () => SignatureRepositoryImpl(datasource: getIt()),
    );
}
