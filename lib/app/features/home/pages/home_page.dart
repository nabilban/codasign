import 'package:codasign/app/features/home/cubit/saved_signatures_cubit.dart';
import 'package:codasign/app/features/home/cubit/signed_documents_cubit.dart';
import 'package:codasign/app/features/home/widgets/home_bottom_widgets.dart';
import 'package:codasign/app/features/home/widgets/home_top_widgets.dart';
import 'package:codasign/app/providers/providers.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SavedSignaturesCubit(
            repository: getIt(),
          )..loadSignatures(),
        ),
        BlocProvider(
          create: (context) => SignedDocumentsCubit(
            repository: getIt(),
          )..loadDocuments(),
        ),
      ],
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 0.5, 1.0],
              colors: AppColors.backgroundGradient,
            ),
          ),
          child: const SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderSection(),
                  QuickActionsSection(),
                  StatsSection(),
                  SignaturesSection(),
                  DocumentsSection(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
