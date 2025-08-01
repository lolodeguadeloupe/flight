import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../network/supabase_client.dart';
import '../../shared/domain/repositories/claim_repository.dart';
import '../../shared/data/repositories/claim_repository_impl.dart';
import '../../shared/data/datasources/local_data_source.dart';
import '../../shared/data/datasources/local_data_source_impl.dart';
import '../../shared/domain/entities/claim.dart';
import '../../core/error/failures.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/domain/entities/auth_user.dart';

// ============================================================================
// Core Infrastructure Providers
// ============================================================================

// Local Data Source Provider
final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  return LocalDataSourceImpl();
});

// Claim Repository Provider
final claimRepositoryProvider = Provider<ClaimRepository>((ref) {
  return ClaimRepositoryImpl(
    localDataSource: ref.read(localDataSourceProvider),
  );
});

// Auth Remote Data Source Provider
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(SupabaseConfig.client);
});

// Auth Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.read(authRemoteDataSourceProvider));
});

// ============================================================================
// Authentication Providers
// ============================================================================

// Current authenticated user stream
final authStateProvider = StreamProvider<AuthUser?>((ref) {
  final authRepository = ref.read(authRepositoryProvider);
  return authRepository.authStateChanges;
});

// Current user provider (nullable)
final currentUserProvider = FutureProvider<AuthUser?>((ref) async {
  final authRepository = ref.read(authRepositoryProvider);
  final result = await authRepository.getCurrentUser();
  return result.fold(
    (failure) => null, // Return null on failure
    (user) => user,
  );
});

// Sign in provider
final signInProvider = FutureProvider.family<Either<Failure, AuthUser>, SignInParams>((ref, params) async {
  final authRepository = ref.read(authRepositoryProvider);
  return await authRepository.signInWithEmail(
    email: params.email,
    password: params.password,
  );
});

// Sign up provider
final signUpProvider = FutureProvider.family<Either<Failure, AuthUser>, SignUpParams>((ref, params) async {
  final authRepository = ref.read(authRepositoryProvider);
  return await authRepository.signUpWithEmail(
    email: params.email,
    password: params.password,
    displayName: params.displayName,
  );
});

// ============================================================================
// Claim Management Providers
// ============================================================================

// User claims provider
final userClaimsProvider = FutureProvider.family<Either<Failure, List<Claim>>, String>((ref, userId) async {
  final claimRepository = ref.read(claimRepositoryProvider);
  return await claimRepository.getUserClaims(userId);
});

// Submit claim provider
final submitClaimProvider = FutureProvider.family<Either<Failure, Claim>, Claim>((ref, claim) async {
  final claimRepository = ref.read(claimRepositoryProvider);
  return await claimRepository.submitClaim(claim);
});

// Get claim details provider
final claimDetailsProvider = FutureProvider.family<Either<Failure, Claim>, String>((ref, claimId) async {
  final claimRepository = ref.read(claimRepositoryProvider);
  return await claimRepository.getClaimDetails(claimId);
});

// Draft claim provider
final draftClaimProvider = FutureProvider.family<Either<Failure, Claim?>, String>((ref, userId) async {
  final claimRepository = ref.read(claimRepositoryProvider);
  return await claimRepository.getDraftClaim(userId);
});

// Save draft claim provider
final saveDraftClaimProvider = FutureProvider.family<Either<Failure, void>, Claim>((ref, draftClaim) async {
  final claimRepository = ref.read(claimRepositoryProvider);
  return await claimRepository.saveDraftClaim(draftClaim);
});

// ============================================================================
// Compensation Calculation Provider
// ============================================================================

// Compensation calculation provider using Edge Functions
final compensationCalculatorProvider = FutureProvider.family<double, CompensationParams>((ref, params) async {
  try {
    // Use Supabase Edge Function for complex calculations
    final response = await SupabaseConfig.rpc<Map<String, dynamic>>(
      'calculate_compensation',
      params: {
        'departure_airport': params.departureAirport,
        'arrival_airport': params.arrivalAirport,
        'delay_duration': params.delayDuration,
        'flight_date': params.flightDate,
      },
    );
    
    return (response['compensation'] as num).toDouble();
  } catch (e) {
    // Fallback to simple local calculation if Edge Function fails
    return _calculateCompensationLocally(params);
  }
});

// Simple local compensation calculation fallback
double _calculateCompensationLocally(CompensationParams params) {
  final delayHours = params.delayDuration;
  
  if (delayHours < 3) return 0.0;
  
  // Simple EC261 calculation (would be more complex in reality)
  if (delayHours >= 4) {
    return 600.0; // Long haul compensation
  } else {
    return 400.0; // Medium haul compensation
  }
}

// ============================================================================
// Data Transfer Objects for Providers
// ============================================================================

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });
}

class SignUpParams {
  final String email;
  final String password;
  final String? displayName;

  SignUpParams({
    required this.email,
    required this.password,
    this.displayName,
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

// Legacy ClaimData class for backward compatibility (deprecated)
@Deprecated('Use Claim entity directly')
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