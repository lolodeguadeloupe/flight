import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/repositories/claim_repository.dart';
import '../../domain/entities/claim.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/supabase_client.dart';
import '../datasources/local_data_source.dart';
import '../models/claim_model.dart';

class ClaimRepositoryImpl implements ClaimRepository {
  final LocalDataSource localDataSource;

  ClaimRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Claim>>> getUserClaims(String userId) async {
    try {
      // Vérifier le cache local d'abord
      final cachedClaims = await localDataSource.getCachedClaims(userId);
      if (cachedClaims != null && cachedClaims.isNotEmpty) {
        return Right(cachedClaims.map((model) => model.toEntity()).toList());
      }

      // Récupérer depuis Supabase
      final response = await SupabaseConfig.from('claims')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final claimModels = response
          .map<ClaimModel>((json) => ClaimModel.fromJson(json))
          .toList();
      final claims = claimModels.map((model) => model.toEntity()).toList();

      // Mettre en cache
      await localDataSource.cacheClaims(claimModels, userId);

      return Right(claims);
    } on PostgrestException catch (e) {
      return Left(_handlePostgrestException(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Claim>> getClaimDetails(String claimId) async {
    try {
      // Vérifier le cache local d'abord
      final cachedClaim = await localDataSource.getCachedClaim(claimId);
      if (cachedClaim != null) {
        return Right(cachedClaim.toEntity());
      }

      // Récupérer depuis Supabase
      final response = await SupabaseConfig.from('claims')
          .select()
          .eq('id', claimId)
          .single();

      final claimModel = ClaimModel.fromJson(response);
      final claim = claimModel.toEntity();

      // Mettre en cache
      await localDataSource.cacheClaim(claimModel);

      return Right(claim);
    } on PostgrestException catch (e) {
      return Left(_handlePostgrestException(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Claim>> submitClaim(Claim claim) async {
    try {
      // Validation pré-soumission
      if (!claim.isEligibleForSubmission) {
        return Left(Failure.validation(
          message: 'Claim is not eligible for submission',
          fieldErrors: _getValidationErrors(claim),
        ));
      }

      // Convertir en modèle pour Supabase
      final claimModel = ClaimModel.fromEntity(claim);
      final claimData = claimModel.toJson();

      // Ajouter l'ID utilisateur actuel et timestamp
      final currentUser = SupabaseConfig.auth.currentUser;
      if (currentUser == null) {
        return const Left(Failure.unauthorized(message: 'User not authenticated'));
      }

      claimData['user_id'] = currentUser.id;
      claimData['created_at'] = DateTime.now().toIso8601String();
      claimData['updated_at'] = DateTime.now().toIso8601String();
      claimData['status'] = 'pending';

      // Soumettre à Supabase
      final response = await SupabaseConfig.from('claims')
          .insert(claimData)
          .select()
          .single();

      final submittedClaimModel = ClaimModel.fromJson(response);
      final submittedClaim = submittedClaimModel.toEntity();

      // Mettre en cache la réclamation soumise
      await localDataSource.cacheClaim(submittedClaimModel);

      // Supprimer le brouillon s'il existe
      await localDataSource.clearDraftClaim(claim.userId);

      return Right(submittedClaim);
    } on AuthException catch (e) {
      return Left(Failure.unauthorized(message: 'Authentication error: ${e.message}'));
    } on PostgrestException catch (e) {
      return Left(_handlePostgrestException(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Failed to submit claim: $e'));
    }
  }

  @override
  Future<Either<Failure, Claim>> updateClaim(String claimId, Map<String, dynamic> updates) async {
    try {
      updates['updated_at'] = DateTime.now().toIso8601String();

      final response = await SupabaseConfig.from('claims')
          .update(updates)
          .eq('id', claimId)
          .select()
          .single();

      final updatedClaimModel = ClaimModel.fromJson(response);
      final updatedClaim = updatedClaimModel.toEntity();

      // Mettre à jour le cache
      await localDataSource.cacheClaim(updatedClaimModel);

      return Right(updatedClaim);
    } on PostgrestException catch (e) {
      return Left(_handlePostgrestException(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Failed to update claim: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveDraftClaim(Claim draftClaim) async {
    try {
      final draftModel = ClaimModel.fromEntity(draftClaim);
      await localDataSource.saveDraftClaim(draftModel);
      return const Right(null);
    } catch (e) {
      return Left(Failure.cache(
        message: 'Failed to save draft claim: $e',
        key: 'draft_${draftClaim.userId}',
      ));
    }
  }

  @override
  Future<Either<Failure, Claim?>> getDraftClaim(String userId) async {
    try {
      final draftModel = await localDataSource.getDraftClaim(userId);
      if (draftModel == null) {
        return const Right(null);
      }
      return Right(draftModel.toEntity());
    } catch (e) {
      return Left(Failure.cache(
        message: 'Failed to get draft claim: $e',
        key: 'draft_$userId',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> clearDraftClaim(String userId) async {
    try {
      await localDataSource.clearDraftClaim(userId);
      return const Right(null);
    } catch (e) {
      return Left(Failure.cache(
        message: 'Failed to clear draft claim: $e',
        key: 'draft_$userId',
      ));
    }
  }

  @override
  Future<Either<Failure, List<Claim>?>> getCachedClaims(String userId) async {
    try {
      final cachedClaims = await localDataSource.getCachedClaims(userId);
      if (cachedClaims == null) {
        return const Right(null);
      }
      return Right(cachedClaims.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(Failure.cache(
        message: 'Failed to get cached claims: $e',
        key: userId,
      ));
    }
  }

  @override
  Future<Either<Failure, Claim?>> getCachedClaim(String claimId) async {
    try {
      final cachedClaim = await localDataSource.getCachedClaim(claimId);
      if (cachedClaim == null) {
        return const Right(null);
      }
      return Right(cachedClaim.toEntity());
    } catch (e) {
      return Left(Failure.cache(
        message: 'Failed to get cached claim: $e',
        key: claimId,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> clearClaimCache() async {
    try {
      // TODO: Implémenter clearClaimCache dans LocalDataSource
      return const Right(null);
    } catch (e) {
      return Left(Failure.cache(message: 'Failed to clear claim cache: $e'));
    }
  }

  Map<String, String> _getValidationErrors(Claim claim) {
    final errors = <String, String>{};

    if (!claim.hasRequiredDocuments) {
      errors['documents'] = 'Required documents are missing';
    }

    if (!claim.flight.isEligibleForCompensation) {
      errors['flight'] = 'Flight is not eligible for compensation';
    }

    if (claim.user.email.isEmpty) {
      errors['user.email'] = 'User email is required';
    }

    return errors;
  }

  Failure _handlePostgrestException(PostgrestException e) {
    // Handle specific Postgrest error codes
    switch (e.code) {
      case 'PGRST116': // No rows found (404 equivalent)
        return Failure.notFound(
          message: 'Claim not found',
          resource: 'claim',
        );
      case 'PGRST301': // JSON parse error
        return Failure.validation(
          message: 'Invalid data format',
          fieldErrors: {'format': 'Invalid JSON data'},
        );
      case '23505': // Unique constraint violation
        return Failure.validation(
          message: e.message,
          fieldErrors: {'unique': 'Duplicate entry'},
        );
      case '23503': // Foreign key constraint violation
        return Failure.validation(
          message: e.message,
          fieldErrors: {'reference': 'Referenced record not found'},
        );
      case '23502': // Not null constraint violation
        return Failure.validation(
          message: e.message,
          fieldErrors: {'required': 'Required field missing'},
        );
      case '23514': // Check constraint violation
        return Failure.validation(
          message: e.message,
          fieldErrors: {'validation': 'Data validation failed'},
        );
      default:
        // Check HTTP status codes for other errors
        if (e.message.contains('401') || e.message.contains('Unauthorized')) {
          return const Failure.unauthorized(message: 'Authentication required');
        } else if (e.message.contains('403') || e.message.contains('Forbidden')) {
          return const Failure.unauthorized(message: 'Access denied');
        } else if (e.message.contains('500') || e.message.contains('Internal')) {
          return Failure.server(
            message: 'Server error occurred',
            statusCode: 500,
          );
        } else {
          return Failure.unknown(
            message: e.message,
            originalError: e,
          );
        }
    }
  }
}