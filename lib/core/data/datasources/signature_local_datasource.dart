import 'dart:convert';
import 'dart:io';

import 'package:codasign/core/domain/models/saved_signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class SignatureLocalDatasource {
  static const _indexFileName = 'signatures_index.json';
  static const _signaturesDir = 'signatures';

  Future<Directory> _getSignaturesDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final sigDir = Directory('${appDir.path}/$_signaturesDir');
    if (!sigDir.existsSync()) {
      await sigDir.create(recursive: true);
    }
    return sigDir;
  }

  Future<File> _getIndexFile() async {
    final appDir = await getApplicationDocumentsDirectory();
    return File('${appDir.path}/$_indexFileName');
  }

  Future<List<SavedSignature>> loadSignatures() async {
    final indexFile = await _getIndexFile();
    if (!indexFile.existsSync()) return [];

    final content = await indexFile.readAsString();
    final jsonList = jsonDecode(content) as List<dynamic>;

    return jsonList
        .map((e) => SavedSignature.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<SavedSignature> saveSignature({
    required List<int> pngBytes,
    required String name,
  }) async {
    final sigDir = await _getSignaturesDir();
    final id = const Uuid().v4();
    final filePath = '${sigDir.path}/$id.png';

    await File(filePath).writeAsBytes(pngBytes);

    final signature = SavedSignature(
      id: id,
      name: name,
      filePath: filePath,
      createdAt: DateTime.now(),
    );

    final existing = await loadSignatures();
    existing.insert(0, signature);
    await _writeIndex(existing);

    return signature;
  }

  Future<void> deleteSignature(String id) async {
    final existing = await loadSignatures();
    final toDelete = existing.where((s) => s.id == id).toList();

    for (final sig in toDelete) {
      final file = File(sig.filePath);
      if (file.existsSync()) {
        await file.delete();
      }
    }

    final updated = existing.where((s) => s.id != id).toList();
    await _writeIndex(updated);
  }

  Future<void> deleteAllSignatures() async {
    final sigDir = await _getSignaturesDir();
    if (sigDir.existsSync()) {
      await sigDir.delete(recursive: true);
    }
    final indexFile = await _getIndexFile();
    if (indexFile.existsSync()) {
      await indexFile.delete();
    }
  }

  Future<void> _writeIndex(List<SavedSignature> signatures) async {
    final indexFile = await _getIndexFile();
    final jsonStr = jsonEncode(signatures.map((s) => s.toJson()).toList());
    await indexFile.writeAsString(jsonStr);
  }
}
