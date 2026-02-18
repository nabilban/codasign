import 'dart:io';
import 'package:codasign/app/features/document/cubit/pdf_signing_cubit.dart';
import 'package:codasign/app/features/document/cubit/pdf_signing_state.dart';
import 'package:codasign/app/features/document/widgets/signature_picker_sheet.dart';
import 'package:codasign/app/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as sfpdf;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFSigningPage extends StatefulWidget {
  const PDFSigningPage({super.key});

  @override
  State<PDFSigningPage> createState() => _PDFSigningPageState();
}

class _PDFSigningPageState extends State<PDFSigningPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  Size _viewerSize = Size.zero;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: BlocConsumer<PDFSigningCubit, PDFSigningState>(
        listener: (context, state) {
          if (state.saveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Document signed and saved to history!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.popUntil(context, (route) => route.isFirst);
          }
          if (state.failure != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Error: ${state.failure!.message}',
                ),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                _buildHeader(context, state),
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
                            onPageChanged: (details) {
                              context.read<PDFSigningCubit>().updatePage(
                                details.newPageNumber,
                              );
                            },
                          ),
                          if (state.selectedSignature != null)
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
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.primary,
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
                                      height: 80,
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
          return state.selectedSignature == null
              ? FloatingActionButton.extended(
                  onPressed: () => SignaturePickerSheet.show(
                    context,
                    (sig) =>
                        context.read<PDFSigningCubit>().selectSignature(sig),
                  ),
                  label: const Text('Add Signature'),
                  icon: const Icon(Icons.add),
                  backgroundColor: AppColors.primary,
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, PDFSigningState state) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.white),
          ),
          Text(
            'Page ${state.currentPage}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (state.selectedSignature != null)
            TextButton(
              onPressed: state.isSaving
                  ? null
                  : () {
                      final pdfSize = _getPdfPageSize(
                        state.document.path,
                        state.currentPage,
                      );
                      context.read<PDFSigningCubit>().saveSignedDocument(
                        pdfPageWidth: pdfSize.width,
                        pdfPageHeight: pdfSize.height,
                        viewerPageWidth: _viewerSize.width,
                        viewerPageHeight: _viewerSize.height,
                      );
                    },
              child: state.isSaving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Finalize',
                      style: TextStyle(
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

  Widget _buildControls(BuildContext context, PDFSigningState state) {
    if (state.selectedSignature == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1B263B),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.zoom_in, color: Colors.white70),
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
          IconButton(
            onPressed: () => context.read<PDFSigningCubit>().selectSignature(
              state.selectedSignature!,
            ),
            icon: const Icon(Icons.refresh, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
