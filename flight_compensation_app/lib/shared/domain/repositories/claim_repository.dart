import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/claim.dart';

abstract class ClaimRepository {
  Future<Either<Failure, List<Claim>>> getUserClaims(String userId);
  
  Future<Either<Failure, Claim>> getClaimDetails(String claimId);
  
  Future<Either<Failure, Claim>> submitClaim(Claim claim);
  
  Future<Either<Failure, Claim>> updateClaim(String claimId, Map<String, dynamic> updates);
  
  Future<Either<Failure, void>> saveDraftClaim(Claim draftClaim);
  
  Future<Either<Failure, Claim?>> getDraftClaim(String userId);
  
  Future<Either<Failure, void>> clearDraftClaim(String userId);
  
  Future<Either<Failure, List<Claim>?>> getCachedClaims(String userId);
  
  Future<Either<Failure, Claim?>> getCachedClaim(String claimId);
  
  Future<Either<Failure, void>> clearClaimCache();
}