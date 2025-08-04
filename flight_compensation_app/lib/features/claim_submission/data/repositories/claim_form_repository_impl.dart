import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/supabase_client.dart';
import '../../domain/entities/claim_form_step.dart';
import '../../domain/repositories/claim_form_repository.dart';

class ClaimFormRepositoryImpl implements ClaimFormRepository {
  
  @override
  Future<Either<Failure, ClaimFormState>> createDraftClaim(String userId) async {
    try {
      final formId = DateTime.now().millisecondsSinceEpoch.toString();
      
      final initialSteps = [
        FormStepData(
          type: FormStepType.flightInfo,
          data: {},
          validationStatus: StepValidationStatus.invalid,
        ),
        FormStepData(
          type: FormStepType.delayInfo,
          data: {},
          validationStatus: StepValidationStatus.invalid,
        ),
        FormStepData(
          type: FormStepType.passengerInfo,
          data: {},
          validationStatus: StepValidationStatus.invalid,
        ),
        FormStepData(
          type: FormStepType.summary,
          data: {},
          validationStatus: StepValidationStatus.invalid,
        ),
      ];

      final formState = ClaimFormState(
        id: formId,
        userId: userId,
        currentStep: 0,
        steps: initialSteps,
        isDraft: true,
      );

      // Sauvegarder le brouillon en base
      await _saveDraftToDatabase(formState);

      return Right(formState);
    } catch (e) {
      return Left(ServerFailure('Impossible de créer le brouillon: $e'));
    }
  }

  @override
  Future<Either<Failure, ClaimFormState>> saveDraftStep(
    ClaimFormState formState,
    int stepIndex,
    Map<String, dynamic> stepData,
  ) async {
    try {
      final updatedSteps = List<FormStepData>.from(formState.steps);
      
      updatedSteps[stepIndex] = updatedSteps[stepIndex].copyWith(
        data: stepData,
        lastModified: DateTime.now(),
      );

      final updatedFormState = formState.copyWith(
        steps: updatedSteps,
        lastSaved: DateTime.now(),
      );

      // Sauvegarder en base de données
      await _saveDraftToDatabase(updatedFormState);

      return Right(updatedFormState);
    } catch (e) {
      return Left(ServerFailure('Impossible de sauvegarder l\'étape: $e'));
    }
  }

  @override
  Future<Either<Failure, ClaimFormState>> loadDraftClaim(String userId, String formId) async {
    try {
      final response = await SupabaseConfig.from('claim_drafts')
          .select()
          .eq('user_id', userId)
          .eq('form_id', formId)
          .maybeSingle();

      if (response == null) {
        return const Left(NotFoundFailure('Brouillon non trouvé'));
      }

      final formState = _mapDatabaseToFormState(response);
      return Right(formState);
    } catch (e) {
      return Left(ServerFailure('Impossible de charger le brouillon: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ClaimFormState>>> getUserDrafts(String userId) async {
    try {
      final response = await SupabaseConfig.from('claim_drafts')
          .select()
          .eq('user_id', userId)
          .eq('is_active', true)
          .order('updated_at', ascending: false);

      final drafts = response
          .map<ClaimFormState>((data) => _mapDatabaseToFormState(data))
          .toList();

      return Right(drafts);
    } catch (e) {
      return Left(ServerFailure('Impossible de récupérer les brouillons: $e'));
    }
  }

  @override
  Future<Either<Failure, String>> submitClaim(ClaimFormState formState) async {
    try {
      // Vérifier que toutes les étapes sont complètes
      if (!formState.canSubmit) {
        return const Left(ValidationFailure('Toutes les étapes doivent être complétées'));
      }

      final allData = formState.allFormData;
      
      // Préparer les données pour la table claims
      final claimData = {
        'user_id': formState.userId,
        'flight_number': allData['flight_number'],
        'departure_date': allData['departure_date'],
        'departure_airport': allData['departure_airport'],
        'arrival_airport': allData['arrival_airport'],
        'delay_duration': double.parse(allData['delay_duration'].toString()).round(),
        'delay_reason': allData['delay_reason'],
        'passenger_name': allData['passenger_name'],
        'passenger_email': allData['passenger_email'],
        'passenger_phone': allData['passenger_phone'],
        'passenger_address': allData['passenger_address'],
        'estimated_compensation': formState.estimatedCompensation,
        'status': 'SUBMITTED',
        'submitted_at': DateTime.now().toIso8601String(),
        'form_data': allData, // Stocker toutes les données du formulaire
      };

      // Insérer dans la table claims
      final claimResponse = await SupabaseConfig.from('claims')
          .insert(claimData)
          .select()
          .single();

      final claimId = claimResponse['id'].toString();

      // Marquer le brouillon comme soumis
      await SupabaseConfig.from('claim_drafts')
          .update({
            'is_active': false,
            'submitted_claim_id': claimId,
            'submitted_at': DateTime.now().toIso8601String(),
          })
          .eq('form_id', formState.id)
          .eq('user_id', formState.userId);

      return Right(claimId);
    } catch (e) {
      return Left(ServerFailure('Impossible de soumettre la réclamation: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDraft(String userId, String formId) async {
    try {
      await SupabaseConfig.from('claim_drafts')
          .update({'is_active': false})
          .eq('user_id', userId)
          .eq('form_id', formId);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Impossible de supprimer le brouillon: $e'));
    }
  }

  Future<void> _saveDraftToDatabase(ClaimFormState formState) async {
    final draftData = {
      'user_id': formState.userId,
      'form_id': formState.id,
      'current_step': formState.currentStep,
      'steps_data': formState.steps.map((step) => {
        'type': step.type.name,
        'data': step.data,
        'validation_status': step.validationStatus.name,
        'errors': step.errors.map((e) => {
          'field': e.field,
          'message': e.message,
        }).toList(),
        'last_modified': step.lastModified?.toIso8601String(),
        'completed_at': step.completedAt?.toIso8601String(),
      }).toList(),
      'estimated_compensation': formState.estimatedCompensation,
      'is_draft': formState.isDraft,
      'is_active': true,
      'updated_at': DateTime.now().toIso8601String(),
    };

    // Utiliser upsert pour créer ou mettre à jour
    await SupabaseConfig.from('claim_drafts')
        .upsert(draftData, 
          onConflict: 'user_id,form_id',
        );
  }

  ClaimFormState _mapDatabaseToFormState(Map<String, dynamic> data) {
    final stepsData = data['steps_data'] as List<dynamic>;
    
    final steps = stepsData.map<FormStepData>((stepData) {
      final errors = (stepData['errors'] as List<dynamic>?)
          ?.map<FormFieldError>((error) => FormFieldError(
                field: error['field'],
                message: error['message'],
              ))
          .toList() ?? [];

      return FormStepData(
        type: FormStepType.values.firstWhere(
          (type) => type.name == stepData['type'],
        ),
        data: Map<String, dynamic>.from(stepData['data']),
        validationStatus: StepValidationStatus.values.firstWhere(
          (status) => status.name == stepData['validation_status'],
        ),
        errors: errors,
        lastModified: stepData['last_modified'] != null
            ? DateTime.parse(stepData['last_modified'])
            : null,
        completedAt: stepData['completed_at'] != null
            ? DateTime.parse(stepData['completed_at'])
            : null,
      );
    }).toList();

    return ClaimFormState(
      id: data['form_id'],
      userId: data['user_id'],
      currentStep: data['current_step'],
      steps: steps,
      isDraft: data['is_draft'] ?? true,
      lastSaved: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'])
          : null,
      estimatedCompensation: data['estimated_compensation']?.toDouble(),
    );
  }
}