// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthResponseModelImpl _$$AuthResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuthResponseModelImpl(
  id: json['id'] as String,
  email: json['email'] as String,
  emailConfirmed: json['emailConfirmed'] as bool? ?? false,
  displayName: json['displayName'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
  lastSignInAt: json['last_sign_in_at'] == null
      ? null
      : DateTime.parse(json['last_sign_in_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$$AuthResponseModelImplToJson(
  _$AuthResponseModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'emailConfirmed': instance.emailConfirmed,
  'displayName': instance.displayName,
  'avatarUrl': instance.avatarUrl,
  'last_sign_in_at': instance.lastSignInAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
};
