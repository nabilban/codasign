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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0D1B2A),
              Color(0xFF1B263B),
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
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
                  subtitle: 'List all items in Documents directory',
                  onTap: () => _printAllFiles(context),
                ),
              ],
            ],
          ),
        ),
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
        child: ListTile(
          onTap: enabled ? onTap : null,
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
      final entities = appDir.listSync(recursive: true);

      debugPrint('--- DEBBUG: APPLICATION DOCUMENTS DIRECTORY ---');
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
    } catch (e) {
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
