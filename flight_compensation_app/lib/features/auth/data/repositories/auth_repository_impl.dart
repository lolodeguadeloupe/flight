import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AuthUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDataSource.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure('Authentication failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final result = await remoteDataSource.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
      return Right(result.toEntity());
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure('Registration failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure('Sign out failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, AuthUser?>> getCurrentUser() async {
    try {
      final result = await remoteDataSource.getCurrentUser();
      return Right(result?.toEntity());
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure('Failed to get current user: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await remoteDataSource.sendPasswordResetEmail(email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure('Password reset failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> confirmEmail(String token) async {
    try {
      await remoteDataSource.confirmEmail(token);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(_mapAuthExceptionToFailure(e));
    } catch (e) {
      return Left(ServerFailure('Email confirmation failed: ${e.toString()}'));
    }
  }

  @override
  Stream<AuthUser?> get authStateChanges {
    return remoteDataSource.authStateChanges
        .map((model) => model?.toEntity());
  }

  Failure _mapAuthExceptionToFailure(AuthException exception) {
    final message = exception.message.toLowerCase();
    
    if (message.contains('invalid login credentials') ||
        message.contains('invalid email or password')) {
      return const AuthFailure('Invalid email or password');
    } else if (message.contains('email not confirmed')) {
      return const AuthFailure('Please confirm your email address');
    } else if (message.contains('too many requests')) {
      return const AuthFailure('Too many attempts. Please try again later');
    } else if (message.contains('user already registered')) {
      return const AuthFailure('An account with this email already exists');
    } else if (message.contains('weak password')) {
      return const AuthFailure('Password is too weak');
    } else if (message.contains('invalid email')) {
      return const ValidationFailure('Invalid email format');
    }
    
    return AuthFailure(exception.message);
  }
}