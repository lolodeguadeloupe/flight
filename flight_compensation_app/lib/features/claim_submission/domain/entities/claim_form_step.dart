import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_form_step.freezed.dart';

enum FormStepType {
  flightInfo,
  delayInfo,
  passengerInfo,
  summary,
}

enum StepValidationStatus {
  invalid,
  valid,
  completed,
}

@freezed
class FormFieldError with _$FormFieldError {
  const factory FormFieldError({
    required String field,
    required String message,
  }) = _FormFieldError;
}

@freezed
class FormStepData with _$FormStepData {
  const factory FormStepData({
    required FormStepType type,
    required Map<String, dynamic> data,
    required StepValidationStatus validationStatus,
    @Default([]) List<FormFieldError> errors,
    DateTime? lastModified,
    DateTime? completedAt,
  }) = _FormStepData;

  const FormStepData._();

  bool get isValid => validationStatus == StepValidationStatus.valid;
  bool get isCompleted => validationStatus == StepValidationStatus.completed;
  bool get hasErrors => errors.isNotEmpty;

  String get stepTitle {
    switch (type) {
      case FormStepType.flightInfo:
        return 'Informations du vol';
      case FormStepType.delayInfo:
        return 'Détails du retard';
      case FormStepType.passengerInfo:
        return 'Informations personnelles';
      case FormStepType.summary:
        return 'Récapitulatif';
    }
  }

  List<String> get requiredFields {
    switch (type) {
      case FormStepType.flightInfo:
        return ['flight_number', 'departure_date', 'departure_airport', 'arrival_airport'];
      case FormStepType.delayInfo:
        return ['delay_duration', 'delay_reason'];
      case FormStepType.passengerInfo:
        return ['passenger_name', 'passenger_email', 'passenger_address'];
      case FormStepType.summary:
        return [];
    }
  }
}

@freezed
class ClaimFormState with _$ClaimFormState {
  const factory ClaimFormState({
    required String id,
    required String userId,
    required int currentStep,
    required List<FormStepData> steps,
    @Default(false) bool isSubmitting,
    @Default(false) bool isDraft,
    DateTime? lastSaved,
    String? submissionId,
    double? estimatedCompensation,
  }) = _ClaimFormState;

  const ClaimFormState._();

  FormStepData get currentStepData => steps[currentStep];
  
  bool get canProceedToNext => 
      currentStep < steps.length - 1 && currentStepData.isValid;
  
  bool get canGoBack => currentStep > 0;
  
  bool get canSubmit => 
      currentStep == steps.length - 1 && 
      steps.every((step) => step.isCompleted);

  double get completionPercentage {
    final completedSteps = steps.where((step) => step.isCompleted).length;
    return (completedSteps / steps.length) * 100;
  }

  List<FormFieldError> get allErrors => 
      steps.expand((step) => step.errors).toList();

  Map<String, dynamic> get allFormData {
    final Map<String, dynamic> combined = {};
    for (final step in steps) {
      combined.addAll(step.data);
    }
    return combined;
  }
}