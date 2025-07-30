import 'package:freezed_annotation/freezed_annotation.dart';
import 'user.dart';
import 'flight.dart';
import 'document.dart';

part 'claim.freezed.dart';

enum ClaimStatus {
  draft,
  pending,
  submitted,
  inProgress,
  underReview,
  approved,
  rejected,
  paid,
  cancelled,
}

enum ClaimType {
  delay,
  cancellation,
  deniedBoarding,
  downgradedService,
  lostBaggage,
  other,
}

@freezed
class ClaimExpense with _$ClaimExpense {
  const factory ClaimExpense({
    required String id,
    required String category,
    required String description,
    required double amount,
    required String currency,
    DateTime? incurredAt,
    String? documentId,
  }) = _ClaimExpense;
}

@freezed
class Claim with _$Claim {
  const factory Claim({
    required String id,
    required String userId,
    required User user,
    required Flight flight,
    required ClaimType claimType,
    required ClaimStatus status,
    required DateTime submissionDate,
    DateTime? lastUpdateDate,
    String? referenceNumber,
    double? requestedAmount,
    double? approvedAmount,
    String? currency,
    @Default([]) List<Document> attachments,
    @Default([]) List<ClaimExpense> expenses,
    String? description,
    String? rejectionReason,
    Map<String, dynamic>? metadata,
    DateTime? processedAt,
    String? processedBy,
  }) = _Claim;

  const Claim._();

  double get totalExpensesAmount => 
      expenses.fold(0.0, (sum, expense) => sum + expense.amount);

  List<Document> get requiredDocuments {
    final required = <Document>[];
    
    // Always require boarding pass
    final boardingPasses = attachments
        .where((doc) => doc.type == DocumentType.boardingPass)
        .toList();
    required.addAll(boardingPasses);
    
    // For delay claims, require delay confirmation
    if (claimType == ClaimType.delay) {
      final delayConfirmations = attachments
          .where((doc) => doc.type == DocumentType.delayConfirmation)
          .toList();
      required.addAll(delayConfirmations);
    }
    
    return required;
  }

  List<Document> get pendingDocuments => 
      attachments.where((doc) => doc.status == DocumentStatus.pending).toList();

  List<Document> get approvedDocuments => 
      attachments.where((doc) => doc.status == DocumentStatus.approved).toList();

  bool get hasRequiredDocuments {
    final hasBoardingPass = attachments
        .any((doc) => doc.type == DocumentType.boardingPass && 
                     doc.status == DocumentStatus.approved);
    
    if (!hasBoardingPass) return false;
    
    if (claimType == ClaimType.delay) {
      final hasDelayConfirmation = attachments
          .any((doc) => doc.type == DocumentType.delayConfirmation && 
                       doc.status == DocumentStatus.approved);
      return hasDelayConfirmation;
    }
    
    return true;
  }

  bool get isEligibleForSubmission => 
      status == ClaimStatus.draft && 
      hasRequiredDocuments && 
      flight.isEligibleForCompensation;

  String get statusDisplayName {
    switch (status) {
      case ClaimStatus.draft:
        return 'Brouillon';
      case ClaimStatus.pending:
        return 'En attente';
      case ClaimStatus.submitted:
        return 'Soumise';
      case ClaimStatus.inProgress:
        return 'En traitement';
      case ClaimStatus.underReview:
        return 'En révision';
      case ClaimStatus.approved:
        return 'Approuvée';
      case ClaimStatus.rejected:
        return 'Rejetée';
      case ClaimStatus.paid:
        return 'Payée';
      case ClaimStatus.cancelled:
        return 'Annulée';
    }
  }

  String get typeDisplayName {
    switch (claimType) {
      case ClaimType.delay:
        return 'Retard';
      case ClaimType.cancellation:
        return 'Annulation';
      case ClaimType.deniedBoarding:
        return 'Refus d\'embarquement';
      case ClaimType.downgradedService:
        return 'Déclassement';
      case ClaimType.lostBaggage:
        return 'Bagages perdus';
      case ClaimType.other:
        return 'Autre';
    }
  }
}