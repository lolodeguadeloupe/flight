import 'package:freezed_annotation/freezed_annotation.dart';

part 'document.freezed.dart';

enum DocumentType {
  boardingPass,
  receipt,
  delayConfirmation,
  passport,
  id,
  bankStatement,
  hotelReceipt,
  transportReceipt,
  correspondence,
  other,
}

enum DocumentStatus {
  pending,
  processing,
  approved,
  rejected,
  requiresReview,
}

@freezed
class Document with _$Document {
  const factory Document({
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
  }) = _Document;

  const Document._();

  String get fileExtension => fileName.split('.').last.toLowerCase();
  
  double get fileSizeMB => fileSizeBytes / (1024 * 1024);
  
  bool get isImage => ['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(fileExtension);
  
  bool get isPdf => fileExtension == 'pdf';
  
  bool get isValid => fileSizeBytes > 0 && fileName.isNotEmpty && url.isNotEmpty;
  
  bool get requiresOcr => isImage || isPdf;
}