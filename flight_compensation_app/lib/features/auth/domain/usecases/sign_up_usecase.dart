import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, AuthUser>> call({
    required String email,
    required String password,
    required String confirmPassword,
    String? displayName,
  }) async {
    final validationResult = _validateInput(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    
    if (validationResult.isLeft()) {
      return validationResult.fold((failure) => Left(failure), (_) => throw Exception());
    }

    return await repository.signUpWithEmail(
      email: email.trim().toLowerCase(),
      password: password,
      displayName: displayName?.trim(),
    );
  }

  Either<Failure, void> _validateInput({
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return Left(Failure.validation(message: 'All fields are required'));
    }

    if (!_isValidEmail(email)) {
      return Left(Failure.validation(message: 'Invalid email format'));
    }

    if (password.length < 8) {
      return Left(Failure.validation(message: 'Password must be at least 8 characters'));
    }

    if (password != confirmPassword) {
      return Left(Failure.validation(message: 'Passwords do not match'));
    }

    if (!_isStrongPassword(password)) {
      return Left(Failure.validation(
        message: 'Password must contain at least one uppercase letter, one lowercase letter, and one number'
      ));
    }

    return const Right(null);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isStrongPassword(String password) {
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(password);
  }
}