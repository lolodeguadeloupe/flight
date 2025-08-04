import 'package:flutter_test/flutter_test.dart';
import 'package:flight_compensation_app/features/claim_submission/domain/entities/claim_form_step.dart';
import 'package:flight_compensation_app/features/claim_submission/domain/usecases/validate_form_step_usecase.dart';

void main() {
  late ValidateFormStepUseCase useCase;

  setUp(() {
    useCase = ValidateFormStepUseCase();
  });

  group('ValidateFormStepUseCase', () {
    group('Flight Info Validation', () {
      test('should validate correct flight info', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.flightInfo,
          data: {
            'flight_number': 'AF1234',
            'departure_date': '01/01/2024',
            'departure_airport': 'CDG',
            'arrival_airport': 'JFK',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.valid));
        expect(result.errors, isEmpty);
      });

      test('should return errors for invalid flight number', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.flightInfo,
          data: {
            'flight_number': 'INVALID',
            'departure_date': '01/01/2024',
            'departure_airport': 'CDG',
            'arrival_airport': 'JFK',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors, isNotEmpty);
        expect(result.errors.any((e) => e.field == 'flight_number'), isTrue);
      });

      test('should return error for same departure and arrival airports', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.flightInfo,
          data: {
            'flight_number': 'AF1234',
            'departure_date': '01/01/2024',
            'departure_airport': 'CDG',
            'arrival_airport': 'CDG',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors, isNotEmpty);
        expect(result.errors.any((e) => e.field == 'arrival_airport'), isTrue);
      });

      test('should return errors for missing required fields', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.flightInfo,
          data: {},
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors.length, equals(4)); // Tous les champs requis manquants
      });
    });

    group('Delay Info Validation', () {
      test('should validate correct delay info', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.delayInfo,
          data: {
            'delay_duration': '4.5',
            'delay_reason': 'Problème technique sur l\'avion',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.valid));
        expect(result.errors, isEmpty);
      });

      test('should return error for delay less than 3 hours', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.delayInfo,
          data: {
            'delay_duration': '2.5',
            'delay_reason': 'Problème technique',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors, isNotEmpty);
        expect(result.errors.any((e) => e.field == 'delay_duration'), isTrue);
      });

      test('should return error for too short delay reason', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.delayInfo,
          data: {
            'delay_duration': '4.0',
            'delay_reason': 'Court',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors, isNotEmpty);
        expect(result.errors.any((e) => e.field == 'delay_reason'), isTrue);
      });
    });

    group('Passenger Info Validation', () {
      test('should validate correct passenger info', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.passengerInfo,
          data: {
            'passenger_name': 'Jean Dupont',
            'passenger_email': 'jean.dupont@example.com',
            'passenger_phone': '+33 6 12 34 56 78',
            'passenger_address': '123 Rue de la Paix, 75001 Paris, France',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.valid));
        expect(result.errors, isEmpty);
      });

      test('should return error for invalid email format', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.passengerInfo,
          data: {
            'passenger_name': 'Jean Dupont',
            'passenger_email': 'invalid-email',
            'passenger_address': '123 Rue de la Paix, 75001 Paris, France',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors, isNotEmpty);
        expect(result.errors.any((e) => e.field == 'passenger_email'), isTrue);
      });

      test('should return error for incomplete name', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.passengerInfo,
          data: {
            'passenger_name': 'Jean',
            'passenger_email': 'jean@example.com',
            'passenger_address': '123 Rue de la Paix, 75001 Paris, France',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors, isNotEmpty);
        expect(result.errors.any((e) => e.field == 'passenger_name'), isTrue);
      });

      test('should return error for too short address', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.passengerInfo,
          data: {
            'passenger_name': 'Jean Dupont',
            'passenger_email': 'jean@example.com',
            'passenger_address': 'Court',
          },
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.invalid));
        expect(result.errors, isNotEmpty);
        expect(result.errors.any((e) => e.field == 'passenger_address'), isTrue);
      });
    });

    group('Summary Step', () {
      test('should not validate summary step (no validation needed)', () {
        // Arrange
        const stepData = FormStepData(
          type: FormStepType.summary,
          data: {},
          validationStatus: StepValidationStatus.invalid,
        );

        // Act
        final result = useCase.call(stepData);

        // Assert
        expect(result.validationStatus, equals(StepValidationStatus.valid));
        expect(result.errors, isEmpty);
      });
    });
  });
}