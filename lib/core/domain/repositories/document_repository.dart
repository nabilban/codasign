import 'package:codasign/core/domain/models/document_model.dart';
import 'package:codasign/core/domain/models/failure.dart';
import 'package:dartz/dartz.dart';

abstract class DocumentRepository {
  Future<Either<Failure, DocumentModel?>> pickDocument();
  Future<Either<Failure, List<DocumentModel>>> getSavedDocuments();
  Stream<List<DocumentModel>> documentsStream();
  Future<Either<Failure, Unit>> saveSignedDocument(DocumentModel document);
  Future<Either<Failure, Unit>> deleteDocument(String id);
  Future<Either<Failure, Unit>> clearAllDocuments();
}
