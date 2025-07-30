import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    if (email.isEmpty) {
      return Left(ValidationFailure('Email cannot be empty'));
    }

    if (!_isValidEmail(email)) {
      return Left(ValidationFailure('Invalid email format'));
    }

    return await repository.sendPasswordResetEmail(email.trim().toLowerCase());
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}