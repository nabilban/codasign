import 'dart:io';

import 'package:codasign/app/features/home/cubit/saved_signatures_cubit.dart';
import 'package:codasign/app/features/home/cubit/signed_documents_cubit.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  children: [
                    _buildSectionHeader(context, 'Data Management'),
                    const SizedBox(height: 16),
                    _buildSettingsTile(
                      context,
                      icon: Icons.delete_sweep_outlined,
                      title: 'Clear All Data',
                      subtitle: 'Remove all signatures and signed documents',
                      onTap: () => _confirmClearAll(context),
                      isDestructive: true,
                    ),
                    const SizedBox(height: 32),
                    _buildSectionHeader(context, 'General'),
                    const SizedBox(height: 16),
                    _buildSettingsTile(
                      context,
                      icon: Icons.language_outlined,
                      title: 'Language',
                      subtitle: 'Coming soon',
                      enabled: false,
                      onTap: () {},
                    ),
                    const SizedBox(height: 16),
                    _buildSettingsTile(
                      context,
                      icon: Icons.info_outline,
                      title: 'About CodaSign',
                      subtitle: 'Version 1.0.0',
                      onTap: () {},
                    ),
                    if (kDebugMode) ...[
                      const SizedBox(height: 32),
                      _buildSectionHeader(context, 'Developer Tools'),
                      const SizedBox(height: 16),
                      _buildSettingsTile(
                        context,
                        icon: Icons.bug_report_outlined,
                        title: 'Print All Files',
                        subtitle:
                            'List all items in Documents and '
                            'Signatures directory',
                        onTap: () => _printAllFiles(context),
                      ),
                      // const SizedBox(height: 16),
                      // _buildSettingsTile(
                      //   context,
                      //   icon: Icons.folder_open_outlined,
                      //   title: 'Open Documents Folder',
                      //   subtitle: 'Access app files in system explorer',
                      //   onTap: () => _openDocumentsDir(context),
                      // ),
                    ],
                    const SizedBox(height: 40),
                  ],
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
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
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
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Settings',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Text(
                'App configuration & data',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool enabled = true,
  }) {
    final theme = Theme.of(context);
    return Opacity(
      opacity: enabled ? 1.0 : 0.5,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceAlpha,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDestructive
                ? theme.colorScheme.error.withValues(alpha: 0.2)
                : theme.colorScheme.primary.withValues(alpha: 0.1),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(16),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDestructive
                      ? theme.colorScheme.error.withValues(alpha: 0.1)
                      : theme.colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isDestructive
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              title: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDestructive
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurface,
                ),
              ),
              subtitle: Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              trailing: enabled
                  ? Icon(
                      Icons.chevron_right,
                      color: theme.colorScheme.onSurfaceVariant,
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _confirmClearAll(BuildContext context) async {
    final theme = Theme.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1B263B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will permanently delete all your saved signatures and '
          'signed documents. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              'Cancel',
              style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Clear Everything'),
          ),
        ],
      ),
    );

    if ((confirmed ?? false) && context.mounted) {
      await context.read<SavedSignaturesCubit>().clearAll();
      if (context.mounted) {
        await context.read<SignedDocumentsCubit>().clearAll();
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All data cleared successfully'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    }
  }

  Future<void> _printAllFiles(BuildContext context) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final entities = appDir.listSync(recursive: true).where((entity) {
        final path = entity.path;
        return path.contains('/Signatures') || path.contains('/Documents');
      }).toList();

      debugPrint('--- DEBUG: SIGNATURES & DOCUMENTS DIRECTORIES ---');
      debugPrint('Path: ${appDir.path}');
      debugPrint('Total items: ${entities.length}');

      for (var i = 0; i < entities.length; i++) {
        final entity = entities[i];
        final stats = entity.statSync();
        final name = entity.path.split('/').last;
        final type = entity is Directory ? '[DIR ]' : '[FILE]';
        final size = entity is File
            ? '${(stats.size / 1024).toStringAsFixed(2)} KB'
            : '-';
        final date = DateFormat('yyyy-MM-dd HH:mm:ss').format(stats.modified);

        debugPrint('$i. $type $name');
        debugPrint('   Size: $size | Modified: $date');
        debugPrint('   Path: ${entity.path}');
      }
      debugPrint('----------------------------------------------');

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Found ${entities.length} items. Check debug console.',
            ),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    } on Exception catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error listing files: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }
}
