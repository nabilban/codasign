import 'dart:async';

import 'package:codasign/app/features/home/cubit/saved_signatures_cubit.dart';
import 'package:codasign/app/features/signature/cubit/signature_cubit.dart';
import 'package:codasign/app/features/signature/cubit/signature_state.dart';
import 'package:codasign/app/features/signature/widgets/signature_canvas.dart';
import 'package:codasign/app/features/signature/widgets/signature_controls.dart';
import 'package:codasign/app/providers/providers.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:signature/signature.dart' hide SignatureState;

class CreateSignaturePage extends StatefulWidget {
  const CreateSignaturePage({super.key});

  @override
  State<CreateSignaturePage> createState() => _CreateSignaturePageState();
}

class _CreateSignaturePageState extends State<CreateSignaturePage> {
  late SignatureController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SignatureController(
      strokeCap: StrokeCap.round,
      strokeJoin: StrokeJoin.round,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _saveSignature(BuildContext context) async {
    if (_controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please draw a signature first.')),
      );
      return;
    }

    final cubit = context.read<SignatureCubit>();

    // Export with transparent background
    final pngBytes = await _controller.toPngBytes();
    if (pngBytes == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to export signature.')),
        );
      }
      return;
    }

    final now = DateTime.now();
    final name =
        'Signature ${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

    await cubit.saveSignature(bytes: pngBytes, name: name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignatureCubit(
        repository: getIt(),
      ),
      child: BlocConsumer<SignatureCubit, SignatureState>(
        listenWhen: (prev, curr) =>
            prev.saveSuccess != curr.saveSuccess ||
            prev.failure != curr.failure,
        listener: (context, state) {
          if (state.saveSuccess) {
            // Refresh home list
            try {
              unawaited(context.read<SavedSignaturesCubit>().loadSignatures());
            } on Exception catch (_) {}

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Signature saved!'),
                backgroundColor: AppColors.primary,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
            Navigator.pop(context);
          } else if (state.failure != null) {
            state.failure!.map(
              database: (f) => _showError(context, f.message),
              network: (f) => _showError(context, f.message),
              notFound: (f) => _showError(context, f.message),
              unknown: (f) => _showError(context, f.message),
            );
          }
        },
        builder: (context, state) {
          // Update controller settings when state changes
          _controller = SignatureController(
            penStrokeWidth: state.penStrokeWidth,
            penColor: state.penColor,
            strokeCap: StrokeCap.round,
            strokeJoin: StrokeJoin.round,
            points: _controller.points,
          );

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
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SignatureCanvas(controller: _controller),
                            const SizedBox(height: 24),
                            SignatureControls(
                              selectedColor: state.penColor,
                              selectedThickness: state.penStrokeWidth,
                              onColorChanged: (color) => context
                                  .read<SignatureCubit>()
                                  .changePenColor(color),
                              onThicknessChanged: (thickness) => context
                                  .read<SignatureCubit>()
                                  .changePenThickness(thickness),
                            ),
                            const SizedBox(height: 24),
                            _buildActions(context, state),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $message'),
        backgroundColor: Colors.red,
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
            'Create Signature',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(width: 48), // Spacer for centering
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, SignatureState state) {
    final theme = Theme.of(context);
    final isSaving = state.isSaving;

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: OutlinedButton.icon(
            onPressed: isSaving ? null : () => _controller.clear(),
            icon: const Icon(Icons.refresh, size: 20),
            label: const Text('Clear'),
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.onSurface,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 6,
          child: Container(
            decoration: BoxDecoration(
              gradient: isSaving
                  ? null
                  : const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
              color: isSaving
                  ? theme.colorScheme.onSurface.withValues(alpha: 0.1)
                  : null,
              borderRadius: BorderRadius.circular(16),
              boxShadow: isSaving
                  ? null
                  : [
                      BoxShadow(
                        color: theme.colorScheme.primary.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: ElevatedButton.icon(
              onPressed: isSaving ? null : () => _saveSignature(context),
              icon: isSaving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.check, size: 20),
              label: Text(isSaving ? 'Saving...' : 'Save Signature'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: theme.colorScheme.onPrimary,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
