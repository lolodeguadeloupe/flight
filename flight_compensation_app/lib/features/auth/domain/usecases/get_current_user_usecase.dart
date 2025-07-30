import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure, AuthUser?>> call() async {
    return await repository.getCurrentUser();
  }

  Stream<AuthUser?> getAuthStateChanges() {
    return repository.authStateChanges;
  }
}