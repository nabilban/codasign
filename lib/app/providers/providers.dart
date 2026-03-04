import 'package:codasign/app/app.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global providers — datasources, repositories, services, and global cubits.
/// These are placed at the root of the widget tree in [App].
List<SingleChildWidget> globalProviders({
  required SharedPreferences sharedPreferences,
}) {
  return [
    // ── Datasources ──
    Provider<SharedPreferences>.value(value: sharedPreferences),
    Provider<SettingsLocalDatasource>(
      create: (_) => SettingsLocalDatasource(prefs: sharedPreferences),
    ),
    Provider<SignatureLocalDatasource>(
      create: (_) => SignatureLocalDatasource(),
    ),
    Provider<DocumentLocalDatasource>(
      create: (_) => DocumentLocalDatasource(),
    ),
    Provider<PdfMergingService>(
      create: (_) => PdfMergingService(),
    ),

    // ── Repositories (depend on datasources above) ──
    Provider<SettingsRepository>(
      create: (context) => SettingsRepositoryImpl(
        datasource: context.read<SettingsLocalDatasource>(),
      ),
    ),
    Provider<SignatureRepository>(
      create: (context) => SignatureRepositoryImpl(
        datasource: context.read<SignatureLocalDatasource>(),
      ),
    ),
    Provider<DocumentRepository>(
      create: (context) => DocumentRepositoryImpl(
        datasource: context.read<DocumentLocalDatasource>(),
        mergingService: context.read<PdfMergingService>(),
      ),
    ),

    // ── Global Cubits ──
    BlocProvider<LocaleCubit>(
      create: (context) => LocaleCubit(
        repository: context.read<SettingsRepository>(),
      ),
    ),
  ];
}
