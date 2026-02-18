import 'dart:convert';
import 'dart:io';

import 'package:codasign/core/domain/models/document_model.dart';
import 'package:path_provider/path_provider.dart';

class DocumentLocalDatasource {
  static const _indexFileName = 'signed_documents_index.json';

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

  Future<void> saveSignedDocument(DocumentModel document) async {
    final existing = await loadSignedDocuments();
    existing.insert(0, document);
    await _writeIndex(existing);
  }

  Future<void> deleteDocument(String id) async {
    final existing = await loadSignedDocuments();
    final updated = existing.where((d) => d.id != id).toList();
    await _writeIndex(updated);
  }

  Future<void> _writeIndex(List<DocumentModel> documents) async {
    final indexFile = await _getIndexFile();
    final jsonStr = jsonEncode(documents.map((d) => d.toJson()).toList());
    await indexFile.writeAsString(jsonStr);
  }
}
