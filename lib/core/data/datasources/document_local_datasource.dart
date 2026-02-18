import 'dart:convert';
import 'dart:io';

import 'package:codasign/core/domain/models/document_model.dart';
import 'package:path_provider/path_provider.dart';

class DocumentLocalDatasource {
  static const _indexFileName = 'signed_documents_index.json';
  static const _signedDocsDir = 'signed_documents';

  Future<Directory> _getSignedDocsDir() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dir = Directory('${appDir.path}/$_signedDocsDir');
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<File> _getIndexFile() async {
    final appDir = await getApplicationDocumentsDirectory();
    return File('${appDir.path}/$_indexFileName');
  }

  Future<List<DocumentModel>> loadSignedDocuments() async {
    final indexFile = await _getIndexFile();
    if (!indexFile.existsSync()) return [];

    final content = await indexFile.readAsString();
    final jsonList = jsonDecode(content) as List<dynamic>;

    return jsonList
        .map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<DocumentModel> saveSignedDocument(DocumentModel document) async {
    final signedDir = await _getSignedDocsDir();
    final fileName =
        'signed_${DateTime.now().millisecondsSinceEpoch}_${document.name}';
    final newPath = '${signedDir.path}/$fileName';

    // Copy the original file to the new path
    await File(document.path).copy(newPath);

    final updatedDoc = document.copyWith(path: newPath);

    final existing = await loadSignedDocuments();
    existing.insert(0, updatedDoc);
    await _writeIndex(existing);

    return updatedDoc;
  }

  Future<void> deleteDocument(String id) async {
    final existing = await loadSignedDocuments();
    final updated = existing.where((d) => d.id != id).toList();
    await _writeIndex(updated);
  }

  Future<void> deleteAllDocuments() async {
    final dir = await _getSignedDocsDir();
    if (dir.existsSync()) {
      await dir.delete(recursive: true);
    }
    final indexFile = await _getIndexFile();
    if (indexFile.existsSync()) {
      await indexFile.delete();
    }
  }

  Future<void> _writeIndex(List<DocumentModel> documents) async {
    final indexFile = await _getIndexFile();
    final jsonStr = jsonEncode(documents.map((d) => d.toJson()).toList());
    await indexFile.writeAsString(jsonStr);
  }
}
