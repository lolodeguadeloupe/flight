import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/claim_form_step.dart';

abstract class ClaimFormRepository {
  /// Crée un nouveau brouillon de réclamation
  Future<Either<Failure, ClaimFormState>> createDraftClaim(String userId);
  
  /// Sauvegarde une étape du formulaire
  Future<Either<Failure, ClaimFormState>> saveDraftStep(
    ClaimFormState formState,
    int stepIndex,
    Map<String, dynamic> stepData,
  );
  
  /// Charge un brouillon existant
  Future<Either<Failure, ClaimFormState>> loadDraftClaim(String userId, String formId);
  
  /// Récupère tous les brouillons d'un utilisateur
  Future<Either<Failure, List<ClaimFormState>>> getUserDrafts(String userId);
  
  /// Soumet la réclamation finale
  Future<Either<Failure, String>> submitClaim(ClaimFormState formState);
  
  /// Supprime un brouillon
  Future<Either<Failure, void>> deleteDraft(String userId, String formId);
}