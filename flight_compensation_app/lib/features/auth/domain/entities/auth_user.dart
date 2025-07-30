import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String email,
    @Default(false) bool isEmailConfirmed,
    String? displayName,
    String? avatarUrl,
    DateTime? lastSignInAt,
    DateTime? createdAt,
  }) = _AuthUser;

  const AuthUser._();

  bool get isAuthenticated => id.isNotEmpty;
}