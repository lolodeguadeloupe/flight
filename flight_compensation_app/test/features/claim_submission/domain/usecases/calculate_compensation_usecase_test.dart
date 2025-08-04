import 'package:flutter_test/flutter_test.dart';
import 'package:flight_compensation_app/features/claim_submission/domain/usecases/calculate_compensation_usecase.dart';
import 'package:flight_compensation_app/core/error/failures.dart';

void main() {
  late CalculateCompensationUseCase useCase;

  setUp(() {
    useCase = CalculateCompensationUseCase();
  });

  group('CalculateCompensationUseCase', () {
    group('European flights (EC261)', () {
      test('should calculate €250 for short-haul flight with 3+ hours delay', () {
        // Arrange
        const departureAirport = 'CDG'; // Paris
        const arrivalAirport = 'LHR'; // London
        const delayDuration = 3.5;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (compensation) => expect(compensation, equals(250.0)),
        );
      });

      test('should calculate €400 for medium-haul flight with 3+ hours delay', () {
        // Arrange
        const departureAirport = 'CDG'; // Paris
        const arrivalAirport = 'FCO'; // Rome
        const delayDuration = 3.5;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (compensation) => expect(compensation, equals(400.0)),
        );
      });

      test('should calculate €600 for long-haul flight with 4+ hours delay', () {
        // Arrange
        const departureAirport = 'CDG'; // Paris
        const arrivalAirport = 'JFK'; // New York
        const delayDuration = 4.5;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (compensation) => expect(compensation, equals(600.0)),
        );
      });

      test('should calculate €300 for long-haul flight with 3-4 hours delay', () {
        // Arrange
        const departureAirport = 'CDG'; // Paris
        const arrivalAirport = 'JFK'; // New York
        const delayDuration = 3.5;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (compensation) => expect(compensation, equals(300.0)),
        );
      });
    });

    group('Non-European flights', () {
      test('should return €0 for US domestic flights', () {
        // Arrange
        const departureAirport = 'JFK'; // New York
        const arrivalAirport = 'LAX'; // Los Angeles
        const delayDuration = 4.0;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (compensation) => expect(compensation, equals(0.0)),
        );
      });

      test('should calculate compensation for Brazilian flights', () {
        // Arrange
        const departureAirport = 'GRU'; // São Paulo
        const arrivalAirport = 'GIG'; // Rio de Janeiro
        const delayDuration = 4.0;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure'),
          (compensation) => expect(compensation, greaterThan(0.0)),
        );
      });
    });

    group('Validation errors', () {
      test('should return ValidationFailure for delay less than 3 hours', () {
        // Arrange
        const departureAirport = 'CDG';
        const arrivalAirport = 'LHR';
        const delayDuration = 2.5;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (compensation) => fail('Should return failure for short delay'),
        );
      });

      test('should return ValidationFailure for invalid airport codes', () {
        // Arrange
        const departureAirport = 'INVALID';
        const arrivalAirport = 'LHR';
        const delayDuration = 3.5;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (compensation) => fail('Should return failure for invalid airport'),
        );
      });

      test('should return ValidationFailure for negative delay', () {
        // Arrange
        const departureAirport = 'CDG';
        const arrivalAirport = 'LHR';
        const delayDuration = -1.0;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) => expect(failure, isA<ValidationFailure>()),
          (compensation) => fail('Should return failure for negative delay'),
        );
      });
    });

    group('Distance calculation', () {
      test('should handle unknown airport combinations with default distance', () {
        // Arrange
        const departureAirport = 'ABC'; // Unknown airport
        const arrivalAirport = 'XYZ'; // Unknown airport
        const delayDuration = 3.5;

        // Act
        final result = useCase.call(
          departureAirport: departureAirport,
          arrivalAirport: arrivalAirport,
          delayDuration: delayDuration,
        );

        // Assert
        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not return failure for unknown airports'),
          (compensation) => expect(compensation, greaterThanOrEqualTo(0.0)),
        );
      });
    });
  });
}