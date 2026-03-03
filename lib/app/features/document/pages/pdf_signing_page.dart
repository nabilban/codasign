import 'dart:io';

import 'package:codasign/app/features/document/cubit/pdf_signing_cubit.dart';
import 'package:codasign/app/features/document/cubit/pdf_signing_state.dart';
import 'package:codasign/app/features/document/widgets/signature_picker_sheet.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:codasign/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sfpdf;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Signature base height in logical pixels (before scaling).
const double _kSignatureBaseHeight = 80;

/// Padding around the signature overlay container.
const double _kSignaturePadding = 8;

class PDFSigningPage extends StatefulWidget {
  const PDFSigningPage({super.key});

  @override
  State<PDFSigningPage> createState() => _PDFSigningPageState();
}

class _PDFSigningPageState extends State<PDFSigningPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController? _pdfController;
  TextEditingController? _nameController;
  Size _viewerSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfViewerController();
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    _nameController?.dispose();
    super.dispose();
  }

  /// Gets the actual PDF page dimensions in points (1/72 inch)
  Size _getPdfPageSize(String path, int pageIndex) {
    final bytes = File(path).readAsBytesSync();
    final document = sfpdf.PdfDocument(inputBytes: bytes);
    try {
      if (pageIndex < 1 || pageIndex > document.pages.count) {
        return const Size(612, 792); // Default letter size
      }
      final page = document.pages[pageIndex - 1];
      return Size(page.size.width, page.size.height);
    } finally {
      document.dispose();
    }
  }

  /// Gets the total page count from the PDF
  int _getPageCount(String path) {
    final bytes = File(path).readAsBytesSync();
    final document = sfpdf.PdfDocument(inputBytes: bytes);
    try {
      return document.pages.count;
    } finally {
      document.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<PDFSigningCubit, PDFSigningState>(
        listener: (context, state) {
          if (state.saveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l10n.documentSignedSuccess),
                backgroundColor: AppColors.success,
              ),
            );
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  context.l10n.errorPrefix(state.failure!.message),
                ),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          // Preview mode — show the baked PDF
          if (state.previewPdfPath != null) {
            return _buildPreviewMode(context, state);
          }

          // Normal placement mode
          return SafeArea(
            child: Column(
              children: [
                _buildHeader(context, state),
                _buildPageSelector(context, state),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      _viewerSize = Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      );
                      return Stack(
                        children: [
                          SfPdfViewer.file(
                            File(state.document.path),
                            key: _pdfViewerKey,
                            controller: _pdfController,
                            pageLayoutMode: PdfPageLayoutMode.single,
                            enableDoubleTapZooming: false,
                            canShowScrollHead: false,
                            onPageChanged: (details) {
                              context.read<PDFSigningCubit>().updatePage(
                                details.newPageNumber,
                              );
                            },
                          ),
                          if (state.selectedSignature != null &&
                              state.currentPage == state.targetPage)
                            Positioned(
                              left: state.signaturePosition.dx,
                              top: state.signaturePosition.dy,
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  context
                                      .read<PDFSigningCubit>()
                                      .updatePosition(
                                        state.signaturePosition + details.delta,
                                      );
                                },
                                child: Transform.scale(
                                  scale: state.signatureScale,
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      _kSignaturePadding,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primary,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                      color: AppColors.primary.withValues(
                                        alpha: 0.1,
                                      ),
                                    ),
                                    child: Image.file(
                                      File(
                                        state.selectedSignature!.filePath,
                                      ),
                                      height: _kSignatureBaseHeight,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
                _buildControls(context, state),
              ],
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<PDFSigningCubit, PDFSigningState>(
        builder: (context, state) {
          // Hide FAB during preview mode
          if (state.previewPdfPath != null) {
            return const SizedBox.shrink();
          }
          return state.selectedSignature == null
              ? FloatingActionButton.extended(
                  onPressed: () => SignaturePickerSheet.show(
                    context,
                    (sig) =>
                        context.read<PDFSigningCubit>().selectSignature(sig),
                  ),
                  label: Text(context.l10n.addSignature),
                  icon: const Icon(Icons.add),
                  backgroundColor: AppColors.primary,
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  // ─── Preview Mode ──────────────────────────────────────────────────

  Widget _buildPreviewMode(BuildContext context, PDFSigningState state) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Column(
        children: [
          // Preview header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () =>
                      context.read<PDFSigningCubit>().cancelPreview(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  context.l10n.previewTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          // Editable document name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.l10n.documentNameHint,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Builder(
                  builder: (context) {
                    // Initialize controller lazily with current document name
                    _nameController ??= TextEditingController(
                      text: state.document.name,
                    );
                    return TextField(
                      controller: _nameController,
                      onChanged: (value) => context
                          .read<PDFSigningCubit>()
                          .updateDocumentName(value),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.description_outlined,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        hintText: context.l10n.newName,
                        hintStyle: TextStyle(
                          color: AppColors.textSecondary.withValues(alpha: 0.5),
                        ),
                        filled: true,
                        fillColor: AppColors.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Preview PDF viewer
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SfPdfViewer.file(
                  File(state.previewPdfPath!),
                ),
              ),
            ),
          ),
          // Preview action buttons
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        context.read<PDFSigningCubit>().cancelPreview(),
                    icon: const Icon(Icons.edit_outlined),
                    label: Text(context.l10n.backToEdit),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: AppColors.primary),
                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: state.isSaving
                        ? null
                        : () => context.read<PDFSigningCubit>().confirmSave(),
                    icon: state.isSaving
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.check_circle_outline),
                    label: Text(
                      state.isSaving
                          ? context.l10n.saving
                          : context.l10n.saveDocument,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Page Selector ─────────────────────────────────────────────────

  Widget _buildPageSelector(BuildContext context, PDFSigningState state) {
    final pageCount = _getPageCount(state.document.path);
    if (pageCount <= 1) return const SizedBox.shrink();

    return Container(
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(
              Icons.pages_outlined,
              color: AppColors.textSecondary,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            context.l10n.selectPage,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: pageCount,
              separatorBuilder: (_, _) => const SizedBox(width: 6),
              itemBuilder: (context, index) {
                final page = index + 1;
                final isSelected = page == state.targetPage;
                return GestureDetector(
                  onTap: () {
                    context.read<PDFSigningCubit>().setTargetPage(page);
                    _pdfController?.jumpToPage(page);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: isSelected
                          ? null
                          : Border.all(
                              color: AppColors.primary.withValues(alpha: 0.3),
                            ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$page',
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─── Header ────────────────────────────────────────────────────────

  Widget _buildHeader(BuildContext context, PDFSigningState state) {
    final theme = Theme.of(context);
    final pageCount = _getPageCount(state.document.path);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: AppColors.textPrimary),
          ),
          Text(
            context.l10n.pageOf(state.currentPage, pageCount),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (state.selectedSignature != null)
            TextButton.icon(
              onPressed: state.isPreviewing
                  ? null
                  : () {
                      final pdfSize = _getPdfPageSize(
                        state.document.path,
                        state.targetPage,
                      );
                      context.read<PDFSigningCubit>().previewSignedDocument(
                        pdfPageWidth: pdfSize.width,
                        pdfPageHeight: pdfSize.height,
                        viewerPageWidth: _viewerSize.width,
                        viewerPageHeight: _viewerSize.height,
                      );
                    },
              icon: state.isPreviewing
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primary,
                      ),
                    )
                  : const Icon(Icons.preview_outlined, size: 18),
              label: Text(
                state.isPreviewing
                    ? context.l10n.generatingPreview
                    : context.l10n.previewSignature,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ─── Controls ──────────────────────────────────────────────────────

  Widget _buildControls(BuildContext context, PDFSigningState state) {
    if (state.selectedSignature == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Scale slider
          Row(
            children: [
              const Icon(Icons.zoom_in, color: AppColors.textSecondary),
              Expanded(
                child: Slider(
                  value: state.signatureScale,
                  min: 0.5,
                  max: 3,
                  onChanged: (value) =>
                      context.read<PDFSigningCubit>().updateScale(value),
                  activeColor: AppColors.primary,
                  inactiveColor: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Remove button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () =>
                  context.read<PDFSigningCubit>().removeSignature(),
              icon: const Icon(Icons.undo_rounded, size: 18),
              label: Text(context.l10n.removeSignature),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: BorderSide(
                  color: AppColors.error.withValues(alpha: 0.5),
                ),
                foregroundColor: AppColors.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
