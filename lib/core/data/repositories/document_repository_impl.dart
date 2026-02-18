import 'dart:async';

import 'package:codasign/core/data/datasources/document_local_datasource.dart';
import 'package:codasign/core/domain/models/document_model.dart';
import 'package:codasign/core/domain/models/failure.dart';
import 'package:codasign/core/domain/repositories/document_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  DocumentRepositoryImpl({required this.datasource});

  final DocumentLocalDatasource datasource;
  final _controller = StreamController<List<DocumentModel>>.broadcast();

  @override
  Stream<List<DocumentModel>> documentsStream() => _controller.stream;

  Future<void> _refresh() async {
    final docs = await datasource.loadSignedDocuments();
    _controller.add(docs);
  }

  @override
  Future<Either<Failure, DocumentModel?>> pickDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result == null || result.files.single.path == null) {
        return const Right(null);
      }

      final document = DocumentModel(
        id: const Uuid().v4(),
        name: result.files.single.name,
        path: result.files.single.path!,
        size: result.files.single.size,
        pageCount: 0, // Will be updated by the viewer or a more specific tool
        createdAt: DateTime.now(),
      );

      return Right(document);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DocumentModel>>> getSavedDocuments() async {
    try {
      final documents = await datasource.loadSignedDocuments();
      return Right(documents);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSignedDocument(
    DocumentModel document,
  ) async {
    try {
      await datasource.saveSignedDocument(document);
      await _refresh();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteDocument(String id) async {
    try {
      await datasource.deleteDocument(id);
      await _refresh();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAllDocuments() async {
    try {
      await datasource.deleteAllDocuments();
      await _refresh();
      return const Right(unit);
    } on Exception catch (e) {
      return Left(Failure.database(message: e.toString()));
    }
  }
}
