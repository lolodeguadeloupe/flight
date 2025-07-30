import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/document.dart';

abstract class DocumentRepository {
  Future<Either<Failure, Document>> uploadDocument({
    required String filePath,
    required DocumentType type,
    required String fileName,
    Map<String, dynamic>? metadata,
  });
  
  Future<Either<Failure, Document>> getDocumentDetails(String documentId);
  
  Future<Either<Failure, void>> deleteDocument(String documentId);
  
  Future<Either<Failure, Map<String, dynamic>>> processDocumentOcr(String documentId);
  
  Future<Either<Failure, String?>> getDocumentLocalPath(String documentId);
  
  Future<Either<Failure, void>> cacheDocumentFile(String documentId, String localPath);
  
  Future<Either<Failure, Document?>> getCachedDocument(String documentId);
  
  Future<Either<Failure, void>> clearDocumentCache();
}