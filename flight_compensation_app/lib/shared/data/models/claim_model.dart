import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/claim.dart';
import 'user_model.dart';
import 'flight_model.dart';
import 'document_model.dart';

part 'claim_model.freezed.dart';
part 'claim_model.g.dart';

@freezed
class ClaimExpenseModel with _$ClaimExpenseModel {
  const factory ClaimExpenseModel({
    required String id,
    required String category,
    required String description,
    required double amount,
    required String currency,
    DateTime? incurredAt,
    String? documentId,
  }) = _ClaimExpenseModel;

  const ClaimExpenseModel._();

  factory ClaimExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ClaimExpenseModelFromJson(json);

  factory ClaimExpenseModel.fromEntity(ClaimExpense expense) =>
      ClaimExpenseModel(
        id: expense.id,
        category: expense.category,
        description: expense.description,
        amount: expense.amount,
        currency: expense.currency,
        incurredAt: expense.incurredAt,
        documentId: expense.documentId,
      );

  ClaimExpense toEntity() => ClaimExpense(
        id: id,
        category: category,
        description: description,
        amount: amount,
        currency: currency,
        incurredAt: incurredAt,
        documentId: documentId,
      );
}

@freezed
class ClaimModel with _$ClaimModel {
  const factory ClaimModel({
    required String id,
    required String userId,
    required UserModel user,
    required FlightModel flight,
    required ClaimType claimType,
    required ClaimStatus status,
    required DateTime submissionDate,
    DateTime? lastUpdateDate,
    String? referenceNumber,
    double? requestedAmount,
    double? approvedAmount,
    String? currency,
    @Default([]) List<DocumentModel> attachments,
    @Default([]) List<ClaimExpenseModel> expenses,
    String? description,
    String? rejectionReason,
    Map<String, dynamic>? metadata,
    DateTime? processedAt,
    String? processedBy,
  }) = _ClaimModel;

  const ClaimModel._();

  factory ClaimModel.fromJson(Map<String, dynamic> json) =>
      _$ClaimModelFromJson(json);

  factory ClaimModel.fromEntity(Claim claim) => ClaimModel(
        id: claim.id,
        userId: claim.userId,
        user: UserModel.fromEntity(claim.user),
        flight: FlightModel.fromEntity(claim.flight),
        claimType: claim.claimType,
        status: claim.status,
        submissionDate: claim.submissionDate,
        lastUpdateDate: claim.lastUpdateDate,
        referenceNumber: claim.referenceNumber,
        requestedAmount: claim.requestedAmount,
        approvedAmount: claim.approvedAmount,
        currency: claim.currency,
        attachments: claim.attachments
            .map((doc) => DocumentModel.fromEntity(doc))
            .toList(),
        expenses: claim.expenses
            .map((expense) => ClaimExpenseModel.fromEntity(expense))
            .toList(),
        description: claim.description,
        rejectionReason: claim.rejectionReason,
        metadata: claim.metadata,
        processedAt: claim.processedAt,
        processedBy: claim.processedBy,
      );

  Claim toEntity() => Claim(
        id: id,
        userId: userId,
        user: user.toEntity(),
        flight: flight.toEntity(),
        claimType: claimType,
        status: status,
        submissionDate: submissionDate,
        lastUpdateDate: lastUpdateDate,
        referenceNumber: referenceNumber,
        requestedAmount: requestedAmount,
        approvedAmount: approvedAmount,
        currency: currency,
        attachments: attachments.map((doc) => doc.toEntity()).toList(),
        expenses: expenses.map((expense) => expense.toEntity()).toList(),
        description: description,
        rejectionReason: rejectionReason,
        metadata: metadata,
        processedAt: processedAt,
        processedBy: processedBy,
      );
}