import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.network({
    required String message,
    int? statusCode,
    String? endpoint,
  }) = NetworkFailure;

  const factory Failure.validation({
    required String message,
    Map<String, String>? fieldErrors,
    String? field,
  }) = ValidationFailure;

  const factory Failure.server({
    required String message,
    int? statusCode,
    String? endpoint,
  }) = ServerFailure;

  const factory Failure.cache({
    required String message,
    String? key,
  }) = CacheFailure;

  const factory Failure.unauthorized({
    required String message,
    @Default(true) bool requiresLogin,
  }) = UnauthorizedFailure;

  const factory Failure.notFound({
    required String message,
    String? resource,
  }) = NotFoundFailure;

  const factory Failure.timeout({
    required String message,
    Duration? duration,
  }) = TimeoutFailure;

  const factory Failure.fileUpload({
    required String message,
    String? fileName,
    int? fileSizeBytes,
  }) = FileUploadFailure;

  const factory Failure.documentProcessing({
    required String message,
    String? documentId,
    String? processingStep,
  }) = DocumentProcessingFailure;

  const factory Failure.compensation({
    required String message,
    String? flightNumber,
    String? reason,
  }) = CompensationFailure;

  const factory Failure.permission({
    required String message,
    String? permission,
  }) = PermissionFailure;

  const factory Failure.unknown({
    required String message,
    Object? originalError,
  }) = UnknownFailure;
}

extension FailureExtension on Failure {
  String get displayMessage {
    return when(
      network: (message, statusCode, endpoint) => 
          'Erreur réseau: $message${statusCode != null ? ' ($statusCode)' : ''}',
      validation: (message, fieldErrors, field) => 
          'Erreur de validation: $message',
      server: (message, statusCode, endpoint) => 
          'Erreur serveur: $message${statusCode != null ? ' ($statusCode)' : ''}',
      cache: (message, key) => 'Erreur de cache: $message',
      unauthorized: (message, requiresLogin) => 
          'Non autorisé: $message${requiresLogin ? ' - Connexion requise' : ''}',
      notFound: (message, resource) => 
          'Non trouvé: $message${resource != null ? ' ($resource)' : ''}',
      timeout: (message, duration) => 
          'Délai d\'attente dépassé: $message${duration != null ? ' (${duration.inSeconds}s)' : ''}',
      fileUpload: (message, fileName, fileSizeBytes) => 
          'Erreur d\'upload: $message${fileName != null ? ' ($fileName)' : ''}',
      documentProcessing: (message, documentId, processingStep) => 
          'Erreur de traitement: $message${processingStep != null ? ' ($processingStep)' : ''}',
      compensation: (message, flightNumber, reason) => 
          'Erreur de compensation: $message${flightNumber != null ? ' ($flightNumber)' : ''}',
      permission: (message, permission) => 
          'Permission refusée: $message${permission != null ? ' ($permission)' : ''}',
      unknown: (message, originalError) => 'Erreur inconnue: $message',
    );
  }

  bool get isRetryable {
    return when(
      network: (_, __, ___) => true,
      server: (_, statusCode, __) => statusCode == null || statusCode >= 500,
      timeout: (_, __) => true,
      fileUpload: (_, __, ___) => true,
      validation: (_, __, ___) => false,
      cache: (_, __) => true,
      unauthorized: (_, __) => false,
      notFound: (_, __) => false,
      documentProcessing: (_, __, ___) => false,
      compensation: (_, __, ___) => false,
      permission: (_, __) => false,
      unknown: (_, __) => false,
    );
  }

  bool get requiresUserAction {
    return when(
      validation: (_, __, ___) => true,
      unauthorized: (_, requiresLogin) => requiresLogin,
      permission: (_, __) => true,
      network: (_, __, ___) => false,
      server: (_, __, ___) => false,
      cache: (_, __) => false,
      notFound: (_, __) => false,
      timeout: (_, __) => false,
      fileUpload: (_, __, ___) => false,
      documentProcessing: (_, __, ___) => false,
      compensation: (_, __, ___) => true,
      unknown: (_, __) => false,
    );
  }
}