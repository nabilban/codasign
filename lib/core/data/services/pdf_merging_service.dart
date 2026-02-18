import 'dart:io';
import 'dart:ui';

import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfMergingService {
  /// Bakes a signature image into a PDF at the specified coordinates.
  ///
  /// [inputPath]: Original PDF path
  /// [outputPath]: Where to save the signed PDF
  /// [signaturePath]: Path to the signature image (PNG)
  /// [pageIndex]: 1-based page index
  /// [x]: X coordinate in PDF points
  /// [y]: Y coordinate in PDF points
  /// [width]: Width in PDF points
  /// [height]: Height in PDF points
  Future<int> bakeSignature({
    required String inputPath,
    required String outputPath,
    required String signaturePath,
    required int pageIndex,
    required double x,
    required double y,
    required double width,
    required double height,
  }) async {
    final bytes = await File(inputPath).readAsBytes();
    final document = PdfDocument(inputBytes: bytes);
    final pageCount = document.pages.count;

    try {
      if (pageIndex > document.pages.count || pageIndex < 1) {
        throw Exception('Invalid page index: $pageIndex');
      }
      final page = document.pages[pageIndex - 1];

      final signatureBytes = await File(signaturePath).readAsBytes();
      final bitmap = PdfBitmap(signatureBytes);

      // Draw signature
      page.graphics.drawImage(
        bitmap,
        Rect.fromLTWH(x, y, width, height),
      );

      final signedBytes = await document.save();
      await File(outputPath).writeAsBytes(signedBytes);

      return pageCount;
    } finally {
      document.dispose();
    }
  }
}
