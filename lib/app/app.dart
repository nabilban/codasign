import 'package:codasign/app/features/home/pages/home_page.dart';
import 'package:codasign/app/features/settings/cubit/locale_cubit.dart';
import 'package:codasign/app/features/settings/cubit/locale_state.dart';
import 'package:codasign/app/providers/providers.dart';
import 'package:codasign/app/ui/theme.dart';
import 'package:codasign/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<LocaleCubit>(),
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return MaterialApp(
            theme: AppTheme.darkTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.locale,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
