import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? nationality,
    @Default(false) bool isEmailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _User;

  const User._();

  String get fullName => '$firstName $lastName';
  
  bool get isProfileComplete => 
      phoneNumber != null && 
      dateOfBirth != null && 
      nationality != null;
}