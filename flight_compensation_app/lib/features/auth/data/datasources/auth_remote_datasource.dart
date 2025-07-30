import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/auth_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthResponseModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  Future<void> signOut();

  Future<AuthResponseModel?> getCurrentUser();

  Future<void> sendPasswordResetEmail(String email);

  Future<void> confirmEmail(String token);

  Stream<AuthResponseModel?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient _supabaseClient;
  late final StreamController<AuthResponseModel?> _authStateController;

  AuthRemoteDataSourceImpl(this._supabaseClient) {
    _authStateController = StreamController<AuthResponseModel?>.broadcast();
    
    // Listen to auth state changes from Supabase
    _supabaseClient.auth.onAuthStateChange.listen((data) {
      final user = data.session?.user;
      if (user != null) {
        _authStateController.add(_mapUserToModel(user));
      } else {
        _authStateController.add(null);
      }
    });
  }

  @override
  Future<AuthResponseModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('Sign in failed: No user returned');
      }

      return _mapUserToModel(user);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponseModel> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'display_name': displayName} : null,
      );

      final user = response.user;
      if (user == null) {
        throw const AuthException('Sign up failed: No user returned');
      }

      return _mapUserToModel(user);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<AuthResponseModel?> getCurrentUser() async {
    try {
      final user = _supabaseClient.auth.currentUser;
      return user != null ? _mapUserToModel(user) : null;
    } catch (e) {
      throw AuthException('Failed to get current user: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabaseClient.auth.resetPasswordForEmail(email);
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Password reset failed: ${e.toString()}');
    }
  }

  @override
  Future<void> confirmEmail(String token) async {
    try {
      await _supabaseClient.auth.verifyOTP(
        token: token,
        type: OtpType.signup,
      );
    } on AuthException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      throw AuthException('Email confirmation failed: ${e.toString()}');
    }
  }

  @override
  Stream<AuthResponseModel?> get authStateChanges => _authStateController.stream;

  AuthResponseModel _mapUserToModel(User user) {
    return AuthResponseModel(
      id: user.id,
      email: user.email ?? '',
      emailConfirmed: user.emailConfirmedAt != null,
      displayName: user.userMetadata?['display_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      lastSignInAt: user.lastSignInAt,
      createdAt: user.createdAt,
    );
  }

  void dispose() {
    _authStateController.close();
  }
}