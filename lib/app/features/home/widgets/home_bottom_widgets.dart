import 'dart:io';

import 'package:codasign/app/features/home/cubit/saved_signatures_cubit.dart';
import 'package:codasign/app/features/home/cubit/saved_signatures_state.dart';
import 'package:codasign/app/features/signature/pages/signature_library_page.dart';
import 'package:codasign/app/features/signature/widgets/signature_preview_dialog.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          OutlinedButton(
            onPressed: () {
              final cubit = context.read<SavedSignaturesCubit>();
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (context) => BlocProvider.value(
                    value: cubit,
                    child: const SignatureLibraryPage(),
                  ),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(
              'View All',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignaturesSection extends StatelessWidget {
  const SignaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedSignaturesCubit, SavedSignaturesState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'My Signatures'),
            if (state.signatures.isEmpty)
              _EmptySignaturesPlaceholder()
            else
              _SignaturesList(signatures: state.signatures),
          ],
        );
      },
    );
  }
}

class _EmptySignaturesPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: AppColors.surfaceAlpha,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.edit_note_outlined,
            size: 40,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 10),
          Text(
            'No signatures yet. Create one to get started!',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignaturesList extends StatelessWidget {
  const _SignaturesList({required this.signatures});

  final List<SavedSignature> signatures;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: signatures.length,
        separatorBuilder: (_, _) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            _SignatureCard(signature: signatures[index]),
      ),
    );
  }
}

class _SignatureCard extends StatelessWidget {
  const _SignatureCard({required this.signature});

  final SavedSignature signature;

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1B263B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Delete Signature?',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'This action cannot be undone.',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.white54,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white54),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<SavedSignaturesCubit>().deleteSignature(
                signature.id,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = DateFormat('MMM d, yyyy').format(signature.createdAt);

    return GestureDetector(
      onTap: () => SignaturePreviewDialog.show(context, signature),
      onLongPress: () => _confirmDelete(context),
      child: Container(
        width: 130,
        decoration: BoxDecoration(
          color: AppColors.surfaceAlpha,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.primary.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Thumbnail area — checkerboard-style bg to show transparency
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: ColoredBox(
                  color: Colors.white,
                  child: Image.file(
                    File(signature.filePath),
                    fit: BoxFit.contain,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            // Name + date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    signature.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    dateStr,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DocumentItem extends StatelessWidget {
  const DocumentItem({
    required this.title,
    required this.subtitle,
    super.key,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceAlpha,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.secondary],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.assignment_turned_in_outlined,
              color: theme.colorScheme.onPrimary,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }
}

class DocumentsSection extends StatelessWidget {
  const DocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionHeader(title: 'Signed PDFs'),
        DocumentItem(
          title: 'Contract Agreement.pdf',
          subtitle: 'Feb 12, 2026 • 5 pages',
        ),
        DocumentItem(
          title: 'NDA Document.pdf',
          subtitle: 'Feb 11, 2026 • 3 pages',
        ),
        DocumentItem(
          title: 'Service Agreement.pdf',
          subtitle: 'Feb 9, 2026 • 8 pages',
        ),
      ],
    );
  }
}
