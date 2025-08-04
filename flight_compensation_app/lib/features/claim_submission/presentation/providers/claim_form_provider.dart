import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/claim_form_step.dart';
import '../../domain/repositories/claim_form_repository.dart';
import '../../domain/usecases/validate_form_step_usecase.dart';
import '../../domain/usecases/calculate_compensation_usecase.dart';
import '../../data/repositories/claim_form_repository_impl.dart';

// Repository provider
final claimFormRepositoryProvider = Provider<ClaimFormRepository>((ref) {
  return ClaimFormRepositoryImpl();
});

// Use cases providers
final validateFormStepUseCaseProvider = Provider<ValidateFormStepUseCase>((ref) {
  return ValidateFormStepUseCase();
});

final calculateCompensationUseCaseProvider = Provider<CalculateCompensationUseCase>((ref) {
  return CalculateCompensationUseCase();
});

// Main form state provider
final claimFormProvider = StateNotifierProvider.autoDispose<ClaimFormNotifier, AsyncValue<ClaimFormState>>((ref) {
  return ClaimFormNotifier(
    repository: ref.watch(claimFormRepositoryProvider),
    validateStepUseCase: ref.watch(validateFormStepUseCaseProvider),
    calculateCompensationUseCase: ref.watch(calculateCompensationUseCaseProvider),
  );
});

class ClaimFormNotifier extends StateNotifier<AsyncValue<ClaimFormState>> {
  final ClaimFormRepository _repository;
  final ValidateFormStepUseCase _validateStepUseCase;
  final CalculateCompensationUseCase _calculateCompensationUseCase;

  ClaimFormNotifier({
    required ClaimFormRepository repository,
    required ValidateFormStepUseCase validateStepUseCase,
    required CalculateCompensationUseCase calculateCompensationUseCase,
  }) : _repository = repository,
       _validateStepUseCase = validateStepUseCase,
       _calculateCompensationUseCase = calculateCompensationUseCase,
       super(const AsyncValue.loading());

  /// Initialise un nouveau formulaire ou charge un brouillon existant
  Future<void> initializeForm(String userId, {String? draftId}) async {
    state = const AsyncValue.loading();
    
    try {
      Either<Failure, ClaimFormState> result;
      
      if (draftId != null) {
        result = await _repository.loadDraftClaim(userId, draftId);
      } else {
        result = await _repository.createDraftClaim(userId);
      }
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (formState) => state = AsyncValue.data(formState),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Met à jour les données d'une étape
  Future<void> updateStepData(int stepIndex, Map<String, dynamic> data) async {
    final currentState = state.value;
    if (currentState == null) return;

    try {
      // Validation de l'étape
      var stepData = currentState.steps[stepIndex].copyWith(data: data);
      stepData = _validateStepUseCase.call(stepData);

      // Calcul de l'indemnisation si on est à l'étape retard
      double? estimatedCompensation = currentState.estimatedCompensation;
      if (stepIndex == 1 && stepData.isValid) { // Étape délai
        final flightData = currentState.steps[0].data;
        final delayData = stepData.data;
        
        if (flightData['departure_airport'] != null && 
            flightData['arrival_airport'] != null &&
            delayData['delay_duration'] != null) {
          
          final compensationResult = _calculateCompensationUseCase.call(
            departureAirport: flightData['departure_airport'],
            arrivalAirport: flightData['arrival_airport'],
            delayDuration: double.parse(delayData['delay_duration'].toString()),
            flightNumber: flightData['flight_number'],
          );
          
          compensationResult.fold(
            (failure) => null,
            (compensation) => estimatedCompensation = compensation,
          );
        }
      }

      // Sauvegarder en base de données
      final result = await _repository.saveDraftStep(currentState, stepIndex, data);
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (updatedFormState) {
          final finalFormState = updatedFormState.copyWith(
            estimatedCompensation: estimatedCompensation,
            steps: updatedFormState.steps.map((step, index) {
              return MapEntry(index, index == stepIndex ? stepData : step);
            }).values.toList(),
          );
          state = AsyncValue.data(finalFormState);
        },
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Marque une étape comme complétée
  Future<void> completeStep(int stepIndex) async {
    final currentState = state.value;
    if (currentState == null) return;

    final stepData = currentState.steps[stepIndex];
    if (!stepData.isValid) return;

    final completedStep = stepData.copyWith(
      validationStatus: StepValidationStatus.completed,
      completedAt: DateTime.now(),
    );

    final updatedSteps = List<FormStepData>.from(currentState.steps);
    updatedSteps[stepIndex] = completedStep;

    final updatedFormState = currentState.copyWith(steps: updatedSteps);
    state = AsyncValue.data(updatedFormState);

    // Sauvegarder l'état
    await _repository.saveDraftStep(currentState, stepIndex, stepData.data);
  }

  /// Passe à l'étape suivante
  Future<void> nextStep() async {
    final currentState = state.value;
    if (currentState == null || !currentState.canProceedToNext) return;

    // Marquer l'étape actuelle comme complétée
    await completeStep(currentState.currentStep);

    // Passer à l'étape suivante
    final updatedFormState = currentState.copyWith(
      currentStep: currentState.currentStep + 1,
    );
    state = AsyncValue.data(updatedFormState);
  }

  /// Revient à l'étape précédente
  void previousStep() {
    final currentState = state.value;
    if (currentState == null || !currentState.canGoBack) return;

    final updatedFormState = currentState.copyWith(
      currentStep: currentState.currentStep - 1,
    );
    state = AsyncValue.data(updatedFormState);
  }

  /// Soumet la réclamation finale
  Future<Either<Failure, String>> submitClaim() async {
    final currentState = state.value;
    if (currentState == null || !currentState.canSubmit) {
      return const Left(ValidationFailure('Le formulaire n\'est pas prêt pour la soumission'));
    }

    state = AsyncValue.data(currentState.copyWith(isSubmitting: true));

    try {
      final result = await _repository.submitClaim(currentState);
      
      result.fold(
        (failure) => state = AsyncValue.error(failure, StackTrace.current),
        (claimId) {
          final submittedState = currentState.copyWith(
            isSubmitting: false,
            submissionId: claimId,
            isDraft: false,
          );
          state = AsyncValue.data(submittedState);
        },
      );

      return result;
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return Left(ServerFailure('Erreur lors de la soumission'));
    }
  }

  /// Valide une étape spécifique
  void validateStep(int stepIndex) {
    final currentState = state.value;
    if (currentState == null) return;

    final stepData = currentState.steps[stepIndex];
    final validatedStep = _validateStepUseCase.call(stepData);

    final updatedSteps = List<FormStepData>.from(currentState.steps);
    updatedSteps[stepIndex] = validatedStep;

    final updatedFormState = currentState.copyWith(steps: updatedSteps);
    state = AsyncValue.data(updatedFormState);
  }

  /// Supprime le brouillon actuel
  Future<void> deleteDraft() async {
    final currentState = state.value;
    if (currentState == null) return;

    await _repository.deleteDraft(currentState.userId, currentState.id);
  }
}

// Provider pour la liste des brouillons de l'utilisateur
final userDraftsProvider = FutureProvider.autoDispose.family<List<ClaimFormState>, String>((ref, userId) async {
  final repository = ref.watch(claimFormRepositoryProvider);
  final result = await repository.getUserDrafts(userId);
  
  return result.fold(
    (failure) => throw failure,
    (drafts) => drafts,
  );
});

// Provider pour les erreurs du formulaire actuel
final formErrorsProvider = Provider.autoDispose<List<FormFieldError>>((ref) {
  final formState = ref.watch(claimFormProvider);
  return formState.when(
    data: (state) => state.allErrors,
    loading: () => [],
    error: (_, __) => [],
  );
});

// Provider pour le pourcentage de completion
final formCompletionProvider = Provider.autoDispose<double>((ref) {
  final formState = ref.watch(claimFormProvider);
  return formState.when(
    data: (state) => state.completionPercentage,
    loading: () => 0.0,
    error: (_, __) => 0.0,
  );
});