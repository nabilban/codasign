import 'dart:io';
import 'package:codasign/app/features/document/cubit/document_selection_cubit.dart';
import 'package:codasign/app/features/document/cubit/document_selection_state.dart';
import 'package:codasign/app/features/document/cubit/pdf_signing_cubit.dart';
import 'package:codasign/app/features/document/cubit/pdf_signing_state.dart';
import 'package:codasign/app/features/document/pages/pdf_signing_page.dart';
import 'package:codasign/app/features/home/cubit/saved_signatures_cubit.dart';
import 'package:codasign/app/providers/providers.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:codasign/core/domain/models/document_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SignDocumentPage extends StatelessWidget {
  const SignDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.0, 0.5, 1.0],
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child:
                    BlocBuilder<DocumentSelectionCubit, DocumentSelectionState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state.selectedDocument == null) {
                          return _buildImportPlaceholder(context);
                        }

                        return _buildDocumentPreview(
                          context,
                          state.selectedDocument!,
                        );
                      },
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                ),
              ),
              child: Icon(
                Icons.arrow_back,
                color: theme.colorScheme.onSurface,
                size: 20,
              ),
            ),
          ),
          Text(
            'Sign Document',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 48), // Spacer for balance
        ],
      ),
    );
  }

  Widget _buildImportPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.upload_file_outlined,
              size: 64,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Import PDF to Sign',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Search locally or via Drive',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () =>
                context.read<DocumentSelectionCubit>().pickDocument(),
            icon: const Icon(Icons.add_rounded),
            label: const Text('Select Document'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentPreview(BuildContext context, DocumentModel document) {
    final theme = Theme.of(context);
    final sizeMb = (document.size / (1024 * 1024)).toStringAsFixed(2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: SfPdfViewer.file(
                File(document.path),
                enableDoubleTapZooming: false,
                enableTextSelection: false,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const _MetaDataTag(
                          icon: Icons.description_outlined,
                          label: 'PDF',
                        ),
                        const SizedBox(width: 8),
                        _MetaDataTag(
                          icon: Icons.sd_storage_outlined,
                          label: '$sizeMb MB',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () =>
                    context.read<DocumentSelectionCubit>().clearSelection(),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final savedSignaturesCubit = context
                    .read<SavedSignaturesCubit>();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => PDFSigningCubit(
                            repository: getIt(),
                            initialState: PDFSigningState.initial(document),
                          ),
                        ),
                        BlocProvider.value(value: savedSignaturesCubit),
                      ],
                      child: const PDFSigningPage(),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 8,
                shadowColor: AppColors.primary.withValues(alpha: 0.5),
              ),
              child: const Text(
                'Prepare for Signing',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaDataTag extends StatelessWidget {
  const _MetaDataTag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
