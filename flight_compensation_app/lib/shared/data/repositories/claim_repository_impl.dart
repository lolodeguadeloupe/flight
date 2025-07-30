import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../domain/repositories/claim_repository.dart';
import '../../domain/entities/claim.dart';
import '../../../core/error/failures.dart';
import '../datasources/local_data_source.dart';
import '../datasources/remote_data_source.dart';
import '../models/claim_model.dart';

class ClaimRepositoryImpl implements ClaimRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  ClaimRepositoryImpl({
    required this.remoteDataSource,
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

      // Récupérer depuis l'API distante
      final claimModels = await remoteDataSource.getUserClaims(userId);
      final claims = claimModels.map((model) => model.toEntity()).toList();

      // Mettre en cache
      await localDataSource.cacheClaims(claimModels, userId);

      return Right(claims);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
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

      // Récupérer depuis l'API distante
      final claimModel = await remoteDataSource.getClaimDetails(claimId);
      final claim = claimModel.toEntity();

      // Mettre en cache
      await localDataSource.cacheClaim(claimModel);

      return Right(claim);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
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

      // Convertir en modèle pour l'API
      final claimModel = ClaimModel.fromEntity(claim);
      final claimData = claimModel.toJson();

      // Soumettre à l'API
      final submittedClaimModel = await remoteDataSource.submitClaim(claimData);
      final submittedClaim = submittedClaimModel.toEntity();

      // Mettre en cache la réclamation soumise
      await localDataSource.cacheClaim(submittedClaimModel);

      // Supprimer le brouillon s'il existe
      await localDataSource.clearDraftClaim(claim.userId);

      return Right(submittedClaim);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      return Left(Failure.unknown(message: 'Failed to submit claim: $e'));
    }
  }

  @override
  Future<Either<Failure, Claim>> updateClaim(String claimId, Map<String, dynamic> updates) async {
    try {
      final updatedClaimModel = await remoteDataSource.updateClaim(claimId, updates);
      final updatedClaim = updatedClaimModel.toEntity();

      // Mettre à jour le cache
      await localDataSource.cacheClaim(updatedClaimModel);

      return Right(updatedClaim);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
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

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Failure.timeout(
          message: 'Request timeout',
          duration: Duration(milliseconds: e.requestOptions.connectTimeout ?? 0),
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 404) {
          return Failure.notFound(
            message: 'Claim not found',
            resource: 'claim',
          );
        } else if (statusCode == 401) {
          return const Failure.unauthorized(message: 'Authentication required');
        } else if (statusCode == 400) {
          return Failure.validation(
            message: e.response?.data?['message'] ?? 'Validation error',
            fieldErrors: e.response?.data?['field_errors'],
          );
        } else {
          return Failure.server(
            message: e.response?.data?['message'] ?? 'Server error',
            statusCode: statusCode,
            endpoint: e.requestOptions.path,
          );
        }
      case DioExceptionType.connectionError:
        return Failure.network(
          message: 'Network connection error',
          endpoint: e.requestOptions.path,
        );
      case DioExceptionType.cancel:
        return const Failure.unknown(message: 'Request was cancelled');
      case DioExceptionType.badCertificate:
        return const Failure.network(message: 'Certificate verification failed');
      case DioExceptionType.unknown:
      default:
        return Failure.unknown(
          message: e.message ?? 'Unknown error occurred',
          originalError: e,
        );
    }
  }
}