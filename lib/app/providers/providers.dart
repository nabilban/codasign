import 'package:codasign/app/features/settings/cubit/locale_cubit.dart';
import 'package:codasign/core/data/datasources/document_local_datasource.dart';
import 'package:codasign/core/data/datasources/settings_local_datasource.dart';
import 'package:codasign/core/data/datasources/signature_local_datasource.dart';
import 'package:codasign/core/data/repositories/document_repository_impl.dart';
import 'package:codasign/core/data/repositories/settings_repository_impl.dart';
import 'package:codasign/core/data/repositories/signature_repository_impl.dart';
import 'package:codasign/core/data/services/pdf_merging_service.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:codasign/core/domain/repositories/settings_repository.dart';
import 'package:codasign/core/domain/repositories/signature_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

void setupProviders({required SharedPreferences sharedPreferences}) {
  getIt
    ..registerLazySingleton<SharedPreferences>(() => sharedPreferences)
    ..registerLazySingleton<SettingsLocalDatasource>(
      () => SettingsLocalDatasource(prefs: getIt()),
    )
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(datasource: getIt()),
    )
    ..registerLazySingleton<LocaleCubit>(() => LocaleCubit(repository: getIt()))
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
