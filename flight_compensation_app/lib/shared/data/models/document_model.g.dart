// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DocumentModelImpl _$$DocumentModelImplFromJson(Map<String, dynamic> json) =>
    _$DocumentModelImpl(
      id: json['id'] as String,
      type: $enumDecode(_$DocumentTypeEnumMap, json['type']),
      fileName: json['fileName'] as String,
      url: json['url'] as String,
      localPath: json['localPath'] as String?,
      fileSizeBytes: (json['fileSizeBytes'] as num).toInt(),
      mimeType: json['mimeType'] as String,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
      status:
          $enumDecodeNullable(_$DocumentStatusEnumMap, json['status']) ??
          DocumentStatus.pending,
      rejectionReason: json['rejectionReason'] as String?,
      extractedData: json['extractedData'] as Map<String, dynamic>?,
      confidenceScore: (json['confidenceScore'] as num?)?.toDouble(),
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
    );

Map<String, dynamic> _$$DocumentModelImplToJson(_$DocumentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$DocumentTypeEnumMap[instance.type]!,
      'fileName': instance.fileName,
      'url': instance.url,
      'localPath': instance.localPath,
      'fileSizeBytes': instance.fileSizeBytes,
      'mimeType': instance.mimeType,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
      'status': _$DocumentStatusEnumMap[instance.status]!,
      'rejectionReason': instance.rejectionReason,
      'extractedData': instance.extractedData,
      'confidenceScore': instance.confidenceScore,
      'processedAt': instance.processedAt?.toIso8601String(),
    };

const _$DocumentTypeEnumMap = {
  DocumentType.boardingPass: 'boardingPass',
  DocumentType.receipt: 'receipt',
  DocumentType.delayConfirmation: 'delayConfirmation',
  DocumentType.passport: 'passport',
  DocumentType.id: 'id',
  DocumentType.bankStatement: 'bankStatement',
  DocumentType.hotelReceipt: 'hotelReceipt',
  DocumentType.transportReceipt: 'transportReceipt',
  DocumentType.correspondence: 'correspondence',
  DocumentType.other: 'other',
};

const _$DocumentStatusEnumMap = {
  DocumentStatus.pending: 'pending',
  DocumentStatus.processing: 'processing',
  DocumentStatus.approved: 'approved',
  DocumentStatus.rejected: 'rejected',
  DocumentStatus.requiresReview: 'requiresReview',
};
