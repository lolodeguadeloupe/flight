import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/auth_user.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    required String id,
    required String email,
    @Default(false) bool emailConfirmed,
    String? displayName,
    String? avatarUrl,
    @JsonKey(name: 'last_sign_in_at') DateTime? lastSignInAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _AuthResponseModel;

  const AuthResponseModel._();

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  AuthUser toEntity() => AuthUser(
        id: id,
        email: email,
        isEmailConfirmed: emailConfirmed,
        displayName: displayName,
        avatarUrl: avatarUrl,
        lastSignInAt: lastSignInAt,
        createdAt: createdAt,
      );
}