import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(Map<String, dynamic> userData);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, String>> refreshToken(String refreshToken);
  
  Future<Either<Failure, User>> getUserProfile(String userId);
  Future<Either<Failure, User>> updateUserProfile(String userId, Map<String, dynamic> data);
  
  Future<Either<Failure, User?>> getCachedUser(String userId);
  Future<Either<Failure, void>> clearUserCache();
}