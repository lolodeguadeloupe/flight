// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ClaimExpenseModelImpl _$$ClaimExpenseModelImplFromJson(
  Map<String, dynamic> json,
) => _$ClaimExpenseModelImpl(
  id: json['id'] as String,
  category: json['category'] as String,
  description: json['description'] as String,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String,
  incurredAt: json['incurredAt'] == null
      ? null
      : DateTime.parse(json['incurredAt'] as String),
  documentId: json['documentId'] as String?,
);

Map<String, dynamic> _$$ClaimExpenseModelImplToJson(
  _$ClaimExpenseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'category': instance.category,
  'description': instance.description,
  'amount': instance.amount,
  'currency': instance.currency,
  'incurredAt': instance.incurredAt?.toIso8601String(),
  'documentId': instance.documentId,
};

_$ClaimModelImpl _$$ClaimModelImplFromJson(Map<String, dynamic> json) =>
    _$ClaimModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      flight: FlightModel.fromJson(json['flight'] as Map<String, dynamic>),
      claimType: $enumDecode(_$ClaimTypeEnumMap, json['claimType']),
      status: $enumDecode(_$ClaimStatusEnumMap, json['status']),
      submissionDate: DateTime.parse(json['submissionDate'] as String),
      lastUpdateDate: json['lastUpdateDate'] == null
          ? null
          : DateTime.parse(json['lastUpdateDate'] as String),
      referenceNumber: json['referenceNumber'] as String?,
      requestedAmount: (json['requestedAmount'] as num?)?.toDouble(),
      approvedAmount: (json['approvedAmount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      attachments:
          (json['attachments'] as List<dynamic>?)
              ?.map((e) => DocumentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      expenses:
          (json['expenses'] as List<dynamic>?)
              ?.map(
                (e) => ClaimExpenseModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      description: json['description'] as String?,
      rejectionReason: json['rejectionReason'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      processedAt: json['processedAt'] == null
          ? null
          : DateTime.parse(json['processedAt'] as String),
      processedBy: json['processedBy'] as String?,
    );

Map<String, dynamic> _$$ClaimModelImplToJson(_$ClaimModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'user': instance.user,
      'flight': instance.flight,
      'claimType': _$ClaimTypeEnumMap[instance.claimType]!,
      'status': _$ClaimStatusEnumMap[instance.status]!,
      'submissionDate': instance.submissionDate.toIso8601String(),
      'lastUpdateDate': instance.lastUpdateDate?.toIso8601String(),
      'referenceNumber': instance.referenceNumber,
      'requestedAmount': instance.requestedAmount,
      'approvedAmount': instance.approvedAmount,
      'currency': instance.currency,
      'attachments': instance.attachments,
      'expenses': instance.expenses,
      'description': instance.description,
      'rejectionReason': instance.rejectionReason,
      'metadata': instance.metadata,
      'processedAt': instance.processedAt?.toIso8601String(),
      'processedBy': instance.processedBy,
    };

const _$ClaimTypeEnumMap = {
  ClaimType.delay: 'delay',
  ClaimType.cancellation: 'cancellation',
  ClaimType.deniedBoarding: 'deniedBoarding',
  ClaimType.downgradedService: 'downgradedService',
  ClaimType.lostBaggage: 'lostBaggage',
  ClaimType.other: 'other',
};

const _$ClaimStatusEnumMap = {
  ClaimStatus.draft: 'draft',
  ClaimStatus.pending: 'pending',
  ClaimStatus.submitted: 'submitted',
  ClaimStatus.inProgress: 'inProgress',
  ClaimStatus.underReview: 'underReview',
  ClaimStatus.approved: 'approved',
  ClaimStatus.rejected: 'rejected',
  ClaimStatus.paid: 'paid',
  ClaimStatus.cancelled: 'cancelled',
};
