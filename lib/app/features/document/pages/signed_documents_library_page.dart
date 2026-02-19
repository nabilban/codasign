import 'package:codasign/app/features/document/pages/signed_document_preview_page.dart';
import 'package:codasign/app/features/home/cubit/signed_documents_cubit.dart';
import 'package:codasign/app/features/home/cubit/signed_documents_state.dart';
import 'package:codasign/app/features/home/widgets/home_bottom_widgets.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:codasign/core/domain/models/document_model.dart';
import 'package:codasign/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class SignedDocumentsLibraryPage extends StatelessWidget {
  const SignedDocumentsLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
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
              _LibraryHeader(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: StatsSection(),
              ),
              Expanded(
                child: BlocBuilder<SignedDocumentsCubit, SignedDocumentsState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state.documents.isEmpty) {
                      return Center(
                        child: Text(
                          context.l10n.noDocumentsFound,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 20,
                        right: 20,
                        bottom: 40,
                      ),
                      itemCount: state.documents.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) => _LibraryDocumentCard(
                        document: state.documents[index],
                      ),
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
}

class _LibraryHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
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
          const SizedBox(width: 16),
          Text(
            context.l10n.signedDocuments,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _LibraryDocumentCard extends StatelessWidget {
  const _LibraryDocumentCard({required this.document});

  final DocumentModel document;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('MMM dd, yyyy').format(document.createdAt);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => SignedDocumentPreviewPage(document: document),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceAlpha,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.secondary],
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.description_rounded,
                color: theme.colorScheme.onPrimary,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.signedOnDate(dateStr),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    final file = XFile(document.path);
                    Share.shareXFiles([
                      file,
                    ], text: context.l10n.shareSignedDocument(document.name));
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                IconButton(
                  onPressed: () => _confirmDelete(context),
                  icon: Icon(
                    Icons.delete_outline,
                    color: theme.colorScheme.error,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1B263B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          context.l10n.deleteDocumentTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          context.l10n.deleteDocumentContent,
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              context.l10n.cancel,
              style: const TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<SignedDocumentsCubit>().removeDocument(document.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(context.l10n.delete),
          ),
        ],
      ),
    );
  }
}
