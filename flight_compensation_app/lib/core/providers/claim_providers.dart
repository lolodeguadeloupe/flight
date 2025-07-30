import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/supabase_service.dart';

// Provider for creating a new claim
final createClaimProvider = FutureProvider.family<Map<String, dynamic>?, ClaimData>((ref, claimData) async {
  return await SupabaseService.createClaim(
    flightNumber: claimData.flightNumber,
    departureDate: claimData.departureDate,
    departureAirport: claimData.departureAirport,
    arrivalAirport: claimData.arrivalAirport,
    delayDuration: claimData.delayDuration,
    delayReason: claimData.delayReason,
    passengerName: claimData.passengerName,
    passengerEmail: claimData.passengerEmail,
    estimatedCompensation: claimData.estimatedCompensation,
  );
});

// Provider for user claims
final userClaimsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, userEmail) async {
  return await SupabaseService.getUserClaims(userEmail);
});

// Provider for compensation calculation
final compensationCalculatorProvider = FutureProvider.family<double, CompensationParams>((ref, params) async {
  return await SupabaseService.calculateCompensation(
    departureAirport: params.departureAirport,
    arrivalAirport: params.arrivalAirport,
    delayDuration: params.delayDuration,
    flightDate: params.flightDate,
  );
});

// Provider for auth state
final authStateProvider = StreamProvider((ref) {
  return SupabaseService.authStateChanges();
});

// Data classes for type safety
class ClaimData {
  final String flightNumber;
  final String departureDate;
  final String departureAirport;
  final String arrivalAirport;
  final int delayDuration;
  final String delayReason;
  final String passengerName;
  final String passengerEmail;
  final double? estimatedCompensation;

  ClaimData({
    required this.flightNumber,
    required this.departureDate,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.delayDuration,
    required this.delayReason,
    required this.passengerName,
    required this.passengerEmail,
    this.estimatedCompensation,
  });
}

class CompensationParams {
  final String departureAirport;
  final String arrivalAirport;
  final int delayDuration;
  final String flightDate;

  CompensationParams({
    required this.departureAirport,
    required this.arrivalAirport,
    required this.delayDuration,
    required this.flightDate,
  });
}