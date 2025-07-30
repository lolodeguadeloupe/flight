import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/document.dart';

part 'document_model.freezed.dart';
part 'document_model.g.dart';

@freezed
class DocumentModel with _$DocumentModel {
  const factory DocumentModel({
    required String id,
    required DocumentType type,
    required String fileName,
    required String url,
    String? localPath,
    required int fileSizeBytes,
    required String mimeType,
    required DateTime uploadedAt,
    @Default(DocumentStatus.pending) DocumentStatus status,
    String? rejectionReason,
    Map<String, dynamic>? extractedData,
    double? confidenceScore,
    DateTime? processedAt,
  }) = _DocumentModel;

  const DocumentModel._();

  factory DocumentModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentModelFromJson(json);

  factory DocumentModel.fromEntity(Document document) => DocumentModel(
        id: document.id,
        type: document.type,
        fileName: document.fileName,
        url: document.url,
        localPath: document.localPath,
        fileSizeBytes: document.fileSizeBytes,
        mimeType: document.mimeType,
        uploadedAt: document.uploadedAt,
        status: document.status,
        rejectionReason: document.rejectionReason,
        extractedData: document.extractedData,
        confidenceScore: document.confidenceScore,
        processedAt: document.processedAt,
      );

  Document toEntity() => Document(
        id: id,
        type: type,
        fileName: fileName,
        url: url,
        localPath: localPath,
        fileSizeBytes: fileSizeBytes,
        mimeType: mimeType,
        uploadedAt: uploadedAt,
        status: status,
        rejectionReason: rejectionReason,
        extractedData: extractedData,
        confidenceScore: confidenceScore,
        processedAt: processedAt,
      );
}