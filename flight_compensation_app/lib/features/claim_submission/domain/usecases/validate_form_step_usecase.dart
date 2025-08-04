import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/claim_form_step.dart';

class ValidateFormStepUseCase {
  FormStepData call(FormStepData stepData) {
    final errors = <FormFieldError>[];
    
    switch (stepData.type) {
      case FormStepType.flightInfo:
        errors.addAll(_validateFlightInfo(stepData.data));
        break;
      case FormStepType.delayInfo:
        errors.addAll(_validateDelayInfo(stepData.data));
        break;
      case FormStepType.passengerInfo:
        errors.addAll(_validatePassengerInfo(stepData.data));
        break;
      case FormStepType.summary:
        // Summary step doesn't need validation
        break;
    }
    
    final validationStatus = errors.isEmpty 
        ? StepValidationStatus.valid 
        : StepValidationStatus.invalid;
    
    return stepData.copyWith(
      validationStatus: validationStatus,
      errors: errors,
      lastModified: DateTime.now(),
    );
  }
  
  List<FormFieldError> _validateFlightInfo(Map<String, dynamic> data) {
    final errors = <FormFieldError>[];
    
    // Flight number validation
    final flightNumber = data['flight_number'] as String?;
    if (flightNumber == null || flightNumber.isEmpty) {
      errors.add(const FormFieldError(
        field: 'flight_number',
        message: 'Le numéro de vol est obligatoire',
      ));
    } else if (!RegExp(r'^[A-Z]{2,3}[0-9]{1,4}$').hasMatch(flightNumber.toUpperCase())) {
      errors.add(const FormFieldError(
        field: 'flight_number',
        message: 'Format invalide (ex: AF1234)',
      ));
    }
    
    // Departure date validation
    final departureDate = data['departure_date'] as String?;
    if (departureDate == null || departureDate.isEmpty) {
      errors.add(const FormFieldError(
        field: 'departure_date',
        message: 'La date de départ est obligatoire',
      ));
    }
    
    // Departure airport validation
    final departureAirport = data['departure_airport'] as String?;
    if (departureAirport == null || departureAirport.isEmpty) {
      errors.add(const FormFieldError(
        field: 'departure_airport',
        message: 'L\'aéroport de départ est obligatoire',
      ));
    } else if (departureAirport.length != 3) {
      errors.add(const FormFieldError(
        field: 'departure_airport',
        message: 'Le code aéroport doit contenir 3 lettres',
      ));
    }
    
    // Arrival airport validation
    final arrivalAirport = data['arrival_airport'] as String?;
    if (arrivalAirport == null || arrivalAirport.isEmpty) {
      errors.add(const FormFieldError(
        field: 'arrival_airport',
        message: 'L\'aéroport d\'arrivée est obligatoire',
      ));
    } else if (arrivalAirport.length != 3) {
      errors.add(const FormFieldError(
        field: 'arrival_airport',
        message: 'Le code aéroport doit contenir 3 lettres',
      ));
    }
    
    // Check if departure and arrival airports are different
    if (departureAirport != null && 
        arrivalAirport != null && 
        departureAirport == arrivalAirport) {
      errors.add(const FormFieldError(
        field: 'arrival_airport',
        message: 'L\'aéroport d\'arrivée doit être différent de celui de départ',
      ));
    }
    
    return errors;
  }
  
  List<FormFieldError> _validateDelayInfo(Map<String, dynamic> data) {
    final errors = <FormFieldError>[];
    
    // Delay duration validation
    final delayDurationStr = data['delay_duration'] as String?;
    if (delayDurationStr == null || delayDurationStr.isEmpty) {
      errors.add(const FormFieldError(
        field: 'delay_duration',
        message: 'La durée du retard est obligatoire',
      ));
    } else {
      final delayDuration = double.tryParse(delayDurationStr);
      if (delayDuration == null || delayDuration < 0) {
        errors.add(const FormFieldError(
          field: 'delay_duration',
          message: 'Durée invalide',
        ));
      } else if (delayDuration < 3) {
        errors.add(const FormFieldError(
          field: 'delay_duration',
          message: 'Le retard doit être d\'au moins 3 heures pour une indemnisation',
        ));
      }
    }
    
    // Delay reason validation
    final delayReason = data['delay_reason'] as String?;
    if (delayReason == null || delayReason.trim().isEmpty) {
      errors.add(const FormFieldError(
        field: 'delay_reason',
        message: 'La raison du retard est obligatoire',
      ));
    } else if (delayReason.trim().length < 10) {
      errors.add(const FormFieldError(
        field: 'delay_reason',
        message: 'Veuillez fournir une description plus détaillée (minimum 10 caractères)',
      ));
    }
    
    return errors;
  }
  
  List<FormFieldError> _validatePassengerInfo(Map<String, dynamic> data) {
    final errors = <FormFieldError>[];
    
    // Passenger name validation
    final passengerName = data['passenger_name'] as String?;
    if (passengerName == null || passengerName.trim().isEmpty) {
      errors.add(const FormFieldError(
        field: 'passenger_name',
        message: 'Le nom est obligatoire',
      ));
    } else if (passengerName.trim().split(' ').length < 2) {
      errors.add(const FormFieldError(
        field: 'passenger_name',
        message: 'Veuillez saisir prénom et nom',
      ));
    }
    
    // Email validation
    final email = data['passenger_email'] as String?;
    if (email == null || email.trim().isEmpty) {
      errors.add(const FormFieldError(
        field: 'passenger_email',
        message: 'L\'email est obligatoire',
      ));
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      errors.add(const FormFieldError(
        field: 'passenger_email',
        message: 'Format d\'email invalide',
      ));
    }
    
    // Phone validation (optional)
    final phone = data['passenger_phone'] as String?;
    if (phone != null && 
        phone.isNotEmpty && 
        !RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(phone.replaceAll(RegExp(r'[\s\-\.]'), ''))) {
      errors.add(const FormFieldError(
        field: 'passenger_phone',
        message: 'Format de téléphone invalide',
      ));
    }
    
    // Address validation
    final address = data['passenger_address'] as String?;
    if (address == null || address.trim().isEmpty) {
      errors.add(const FormFieldError(
        field: 'passenger_address',
        message: 'L\'adresse est obligatoire',
      ));
    } else if (address.trim().length < 10) {
      errors.add(const FormFieldError(
        field: 'passenger_address',
        message: 'Veuillez fournir une adresse complète',
      ));
    }
    
    return errors;
  }
}