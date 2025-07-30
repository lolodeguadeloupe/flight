// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Failure {
  String get message => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FailureCopyWith<Failure> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<$Res> {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) then) =
      _$FailureCopyWithImpl<$Res, Failure>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class _$FailureCopyWithImpl<$Res, $Val extends Failure>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NetworkFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NetworkFailureImplCopyWith(
    _$NetworkFailureImpl value,
    $Res Function(_$NetworkFailureImpl) then,
  ) = __$$NetworkFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int? statusCode, String? endpoint});
}

/// @nodoc
class __$$NetworkFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NetworkFailureImpl>
    implements _$$NetworkFailureImplCopyWith<$Res> {
  __$$NetworkFailureImplCopyWithImpl(
    _$NetworkFailureImpl _value,
    $Res Function(_$NetworkFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = freezed,
    Object? endpoint = freezed,
  }) {
    return _then(
      _$NetworkFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        endpoint: freezed == endpoint
            ? _value.endpoint
            : endpoint // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NetworkFailureImpl implements NetworkFailure {
  const _$NetworkFailureImpl({
    required this.message,
    this.statusCode,
    this.endpoint,
  });

  @override
  final String message;
  @override
  final int? statusCode;
  @override
  final String? endpoint;

  @override
  String toString() {
    return 'Failure.network(message: $message, statusCode: $statusCode, endpoint: $endpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode, endpoint);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      __$$NetworkFailureImplCopyWithImpl<_$NetworkFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return network(message, statusCode, endpoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return network?.call(message, statusCode, endpoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(message, statusCode, endpoint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkFailure implements Failure {
  const factory NetworkFailure({
    required final String message,
    final int? statusCode,
    final String? endpoint,
  }) = _$NetworkFailureImpl;

  @override
  String get message;
  int? get statusCode;
  String? get endpoint;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NetworkFailureImplCopyWith<_$NetworkFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ValidationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ValidationFailureImplCopyWith(
    _$ValidationFailureImpl value,
    $Res Function(_$ValidationFailureImpl) then,
  ) = __$$ValidationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Map<String, String>? fieldErrors, String? field});
}

/// @nodoc
class __$$ValidationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ValidationFailureImpl>
    implements _$$ValidationFailureImplCopyWith<$Res> {
  __$$ValidationFailureImplCopyWithImpl(
    _$ValidationFailureImpl _value,
    $Res Function(_$ValidationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fieldErrors = freezed,
    Object? field = freezed,
  }) {
    return _then(
      _$ValidationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        fieldErrors: freezed == fieldErrors
            ? _value._fieldErrors
            : fieldErrors // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>?,
        field: freezed == field
            ? _value.field
            : field // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ValidationFailureImpl implements ValidationFailure {
  const _$ValidationFailureImpl({
    required this.message,
    final Map<String, String>? fieldErrors,
    this.field,
  }) : _fieldErrors = fieldErrors;

  @override
  final String message;
  final Map<String, String>? _fieldErrors;
  @override
  Map<String, String>? get fieldErrors {
    final value = _fieldErrors;
    if (value == null) return null;
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? field;

  @override
  String toString() {
    return 'Failure.validation(message: $message, fieldErrors: $fieldErrors, field: $field)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._fieldErrors,
              _fieldErrors,
            ) &&
            (identical(other.field, field) || other.field == field));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_fieldErrors),
    field,
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      __$$ValidationFailureImplCopyWithImpl<_$ValidationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return validation(message, fieldErrors, field);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return validation?.call(message, fieldErrors, field);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(message, fieldErrors, field);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationFailure implements Failure {
  const factory ValidationFailure({
    required final String message,
    final Map<String, String>? fieldErrors,
    final String? field,
  }) = _$ValidationFailureImpl;

  @override
  String get message;
  Map<String, String>? get fieldErrors;
  String? get field;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationFailureImplCopyWith<_$ValidationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ServerFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$ServerFailureImplCopyWith(
    _$ServerFailureImpl value,
    $Res Function(_$ServerFailureImpl) then,
  ) = __$$ServerFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, int? statusCode, String? endpoint});
}

/// @nodoc
class __$$ServerFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$ServerFailureImpl>
    implements _$$ServerFailureImplCopyWith<$Res> {
  __$$ServerFailureImplCopyWithImpl(
    _$ServerFailureImpl _value,
    $Res Function(_$ServerFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? statusCode = freezed,
    Object? endpoint = freezed,
  }) {
    return _then(
      _$ServerFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        statusCode: freezed == statusCode
            ? _value.statusCode
            : statusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
        endpoint: freezed == endpoint
            ? _value.endpoint
            : endpoint // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ServerFailureImpl implements ServerFailure {
  const _$ServerFailureImpl({
    required this.message,
    this.statusCode,
    this.endpoint,
  });

  @override
  final String message;
  @override
  final int? statusCode;
  @override
  final String? endpoint;

  @override
  String toString() {
    return 'Failure.server(message: $message, statusCode: $statusCode, endpoint: $endpoint)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServerFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.endpoint, endpoint) ||
                other.endpoint == endpoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, statusCode, endpoint);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      __$$ServerFailureImplCopyWithImpl<_$ServerFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return server(message, statusCode, endpoint);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return server?.call(message, statusCode, endpoint);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(message, statusCode, endpoint);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return server(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return server?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (server != null) {
      return server(this);
    }
    return orElse();
  }
}

abstract class ServerFailure implements Failure {
  const factory ServerFailure({
    required final String message,
    final int? statusCode,
    final String? endpoint,
  }) = _$ServerFailureImpl;

  @override
  String get message;
  int? get statusCode;
  String? get endpoint;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServerFailureImplCopyWith<_$ServerFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CacheFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$CacheFailureImplCopyWith(
    _$CacheFailureImpl value,
    $Res Function(_$CacheFailureImpl) then,
  ) = __$$CacheFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? key});
}

/// @nodoc
class __$$CacheFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$CacheFailureImpl>
    implements _$$CacheFailureImplCopyWith<$Res> {
  __$$CacheFailureImplCopyWithImpl(
    _$CacheFailureImpl _value,
    $Res Function(_$CacheFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? key = freezed}) {
    return _then(
      _$CacheFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        key: freezed == key
            ? _value.key
            : key // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CacheFailureImpl implements CacheFailure {
  const _$CacheFailureImpl({required this.message, this.key});

  @override
  final String message;
  @override
  final String? key;

  @override
  String toString() {
    return 'Failure.cache(message: $message, key: $key)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacheFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.key, key) || other.key == key));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, key);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      __$$CacheFailureImplCopyWithImpl<_$CacheFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return cache(message, key);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return cache?.call(message, key);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(message, key);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return cache(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return cache?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (cache != null) {
      return cache(this);
    }
    return orElse();
  }
}

abstract class CacheFailure implements Failure {
  const factory CacheFailure({
    required final String message,
    final String? key,
  }) = _$CacheFailureImpl;

  @override
  String get message;
  String? get key;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CacheFailureImplCopyWith<_$CacheFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnauthorizedFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnauthorizedFailureImplCopyWith(
    _$UnauthorizedFailureImpl value,
    $Res Function(_$UnauthorizedFailureImpl) then,
  ) = __$$UnauthorizedFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, bool requiresLogin});
}

/// @nodoc
class __$$UnauthorizedFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnauthorizedFailureImpl>
    implements _$$UnauthorizedFailureImplCopyWith<$Res> {
  __$$UnauthorizedFailureImplCopyWithImpl(
    _$UnauthorizedFailureImpl _value,
    $Res Function(_$UnauthorizedFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? requiresLogin = null}) {
    return _then(
      _$UnauthorizedFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        requiresLogin: null == requiresLogin
            ? _value.requiresLogin
            : requiresLogin // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$UnauthorizedFailureImpl implements UnauthorizedFailure {
  const _$UnauthorizedFailureImpl({
    required this.message,
    this.requiresLogin = true,
  });

  @override
  final String message;
  @override
  @JsonKey()
  final bool requiresLogin;

  @override
  String toString() {
    return 'Failure.unauthorized(message: $message, requiresLogin: $requiresLogin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnauthorizedFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.requiresLogin, requiresLogin) ||
                other.requiresLogin == requiresLogin));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, requiresLogin);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      __$$UnauthorizedFailureImplCopyWithImpl<_$UnauthorizedFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return unauthorized(message, requiresLogin);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return unauthorized?.call(message, requiresLogin);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(message, requiresLogin);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class UnauthorizedFailure implements Failure {
  const factory UnauthorizedFailure({
    required final String message,
    final bool requiresLogin,
  }) = _$UnauthorizedFailureImpl;

  @override
  String get message;
  bool get requiresLogin;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnauthorizedFailureImplCopyWith<_$UnauthorizedFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotFoundFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$NotFoundFailureImplCopyWith(
    _$NotFoundFailureImpl value,
    $Res Function(_$NotFoundFailureImpl) then,
  ) = __$$NotFoundFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? resource});
}

/// @nodoc
class __$$NotFoundFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$NotFoundFailureImpl>
    implements _$$NotFoundFailureImplCopyWith<$Res> {
  __$$NotFoundFailureImplCopyWithImpl(
    _$NotFoundFailureImpl _value,
    $Res Function(_$NotFoundFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? resource = freezed}) {
    return _then(
      _$NotFoundFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        resource: freezed == resource
            ? _value.resource
            : resource // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$NotFoundFailureImpl implements NotFoundFailure {
  const _$NotFoundFailureImpl({required this.message, this.resource});

  @override
  final String message;
  @override
  final String? resource;

  @override
  String toString() {
    return 'Failure.notFound(message: $message, resource: $resource)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotFoundFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.resource, resource) ||
                other.resource == resource));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, resource);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      __$$NotFoundFailureImplCopyWithImpl<_$NotFoundFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return notFound(message, resource);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return notFound?.call(message, resource);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(message, resource);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return notFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFoundFailure implements Failure {
  const factory NotFoundFailure({
    required final String message,
    final String? resource,
  }) = _$NotFoundFailureImpl;

  @override
  String get message;
  String? get resource;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotFoundFailureImplCopyWith<_$NotFoundFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TimeoutFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$TimeoutFailureImplCopyWith(
    _$TimeoutFailureImpl value,
    $Res Function(_$TimeoutFailureImpl) then,
  ) = __$$TimeoutFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Duration? duration});
}

/// @nodoc
class __$$TimeoutFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$TimeoutFailureImpl>
    implements _$$TimeoutFailureImplCopyWith<$Res> {
  __$$TimeoutFailureImplCopyWithImpl(
    _$TimeoutFailureImpl _value,
    $Res Function(_$TimeoutFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? duration = freezed}) {
    return _then(
      _$TimeoutFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: freezed == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration?,
      ),
    );
  }
}

/// @nodoc

class _$TimeoutFailureImpl implements TimeoutFailure {
  const _$TimeoutFailureImpl({required this.message, this.duration});

  @override
  final String message;
  @override
  final Duration? duration;

  @override
  String toString() {
    return 'Failure.timeout(message: $message, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeoutFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.duration, duration) ||
                other.duration == duration));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, duration);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      __$$TimeoutFailureImplCopyWithImpl<_$TimeoutFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return timeout(message, duration);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return timeout?.call(message, duration);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(message, duration);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return timeout(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return timeout?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (timeout != null) {
      return timeout(this);
    }
    return orElse();
  }
}

abstract class TimeoutFailure implements Failure {
  const factory TimeoutFailure({
    required final String message,
    final Duration? duration,
  }) = _$TimeoutFailureImpl;

  @override
  String get message;
  Duration? get duration;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeoutFailureImplCopyWith<_$TimeoutFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FileUploadFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$FileUploadFailureImplCopyWith(
    _$FileUploadFailureImpl value,
    $Res Function(_$FileUploadFailureImpl) then,
  ) = __$$FileUploadFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? fileName, int? fileSizeBytes});
}

/// @nodoc
class __$$FileUploadFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$FileUploadFailureImpl>
    implements _$$FileUploadFailureImplCopyWith<$Res> {
  __$$FileUploadFailureImplCopyWithImpl(
    _$FileUploadFailureImpl _value,
    $Res Function(_$FileUploadFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? fileName = freezed,
    Object? fileSizeBytes = freezed,
  }) {
    return _then(
      _$FileUploadFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        fileName: freezed == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileSizeBytes: freezed == fileSizeBytes
            ? _value.fileSizeBytes
            : fileSizeBytes // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$FileUploadFailureImpl implements FileUploadFailure {
  const _$FileUploadFailureImpl({
    required this.message,
    this.fileName,
    this.fileSizeBytes,
  });

  @override
  final String message;
  @override
  final String? fileName;
  @override
  final int? fileSizeBytes;

  @override
  String toString() {
    return 'Failure.fileUpload(message: $message, fileName: $fileName, fileSizeBytes: $fileSizeBytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FileUploadFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileSizeBytes, fileSizeBytes) ||
                other.fileSizeBytes == fileSizeBytes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, fileName, fileSizeBytes);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FileUploadFailureImplCopyWith<_$FileUploadFailureImpl> get copyWith =>
      __$$FileUploadFailureImplCopyWithImpl<_$FileUploadFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return fileUpload(message, fileName, fileSizeBytes);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return fileUpload?.call(message, fileName, fileSizeBytes);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (fileUpload != null) {
      return fileUpload(message, fileName, fileSizeBytes);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return fileUpload(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return fileUpload?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (fileUpload != null) {
      return fileUpload(this);
    }
    return orElse();
  }
}

abstract class FileUploadFailure implements Failure {
  const factory FileUploadFailure({
    required final String message,
    final String? fileName,
    final int? fileSizeBytes,
  }) = _$FileUploadFailureImpl;

  @override
  String get message;
  String? get fileName;
  int? get fileSizeBytes;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FileUploadFailureImplCopyWith<_$FileUploadFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DocumentProcessingFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$DocumentProcessingFailureImplCopyWith(
    _$DocumentProcessingFailureImpl value,
    $Res Function(_$DocumentProcessingFailureImpl) then,
  ) = __$$DocumentProcessingFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? documentId, String? processingStep});
}

/// @nodoc
class __$$DocumentProcessingFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$DocumentProcessingFailureImpl>
    implements _$$DocumentProcessingFailureImplCopyWith<$Res> {
  __$$DocumentProcessingFailureImplCopyWithImpl(
    _$DocumentProcessingFailureImpl _value,
    $Res Function(_$DocumentProcessingFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? documentId = freezed,
    Object? processingStep = freezed,
  }) {
    return _then(
      _$DocumentProcessingFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        documentId: freezed == documentId
            ? _value.documentId
            : documentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        processingStep: freezed == processingStep
            ? _value.processingStep
            : processingStep // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$DocumentProcessingFailureImpl implements DocumentProcessingFailure {
  const _$DocumentProcessingFailureImpl({
    required this.message,
    this.documentId,
    this.processingStep,
  });

  @override
  final String message;
  @override
  final String? documentId;
  @override
  final String? processingStep;

  @override
  String toString() {
    return 'Failure.documentProcessing(message: $message, documentId: $documentId, processingStep: $processingStep)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentProcessingFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId) &&
            (identical(other.processingStep, processingStep) ||
                other.processingStep == processingStep));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, message, documentId, processingStep);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentProcessingFailureImplCopyWith<_$DocumentProcessingFailureImpl>
  get copyWith =>
      __$$DocumentProcessingFailureImplCopyWithImpl<
        _$DocumentProcessingFailureImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return documentProcessing(message, documentId, processingStep);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return documentProcessing?.call(message, documentId, processingStep);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (documentProcessing != null) {
      return documentProcessing(message, documentId, processingStep);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return documentProcessing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return documentProcessing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (documentProcessing != null) {
      return documentProcessing(this);
    }
    return orElse();
  }
}

abstract class DocumentProcessingFailure implements Failure {
  const factory DocumentProcessingFailure({
    required final String message,
    final String? documentId,
    final String? processingStep,
  }) = _$DocumentProcessingFailureImpl;

  @override
  String get message;
  String? get documentId;
  String? get processingStep;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentProcessingFailureImplCopyWith<_$DocumentProcessingFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CompensationFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$CompensationFailureImplCopyWith(
    _$CompensationFailureImpl value,
    $Res Function(_$CompensationFailureImpl) then,
  ) = __$$CompensationFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? flightNumber, String? reason});
}

/// @nodoc
class __$$CompensationFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$CompensationFailureImpl>
    implements _$$CompensationFailureImplCopyWith<$Res> {
  __$$CompensationFailureImplCopyWithImpl(
    _$CompensationFailureImpl _value,
    $Res Function(_$CompensationFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? flightNumber = freezed,
    Object? reason = freezed,
  }) {
    return _then(
      _$CompensationFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        flightNumber: freezed == flightNumber
            ? _value.flightNumber
            : flightNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$CompensationFailureImpl implements CompensationFailure {
  const _$CompensationFailureImpl({
    required this.message,
    this.flightNumber,
    this.reason,
  });

  @override
  final String message;
  @override
  final String? flightNumber;
  @override
  final String? reason;

  @override
  String toString() {
    return 'Failure.compensation(message: $message, flightNumber: $flightNumber, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CompensationFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.flightNumber, flightNumber) ||
                other.flightNumber == flightNumber) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, flightNumber, reason);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CompensationFailureImplCopyWith<_$CompensationFailureImpl> get copyWith =>
      __$$CompensationFailureImplCopyWithImpl<_$CompensationFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return compensation(message, flightNumber, reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return compensation?.call(message, flightNumber, reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (compensation != null) {
      return compensation(message, flightNumber, reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return compensation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return compensation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (compensation != null) {
      return compensation(this);
    }
    return orElse();
  }
}

abstract class CompensationFailure implements Failure {
  const factory CompensationFailure({
    required final String message,
    final String? flightNumber,
    final String? reason,
  }) = _$CompensationFailureImpl;

  @override
  String get message;
  String? get flightNumber;
  String? get reason;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CompensationFailureImplCopyWith<_$CompensationFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PermissionFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$PermissionFailureImplCopyWith(
    _$PermissionFailureImpl value,
    $Res Function(_$PermissionFailureImpl) then,
  ) = __$$PermissionFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String? permission});
}

/// @nodoc
class __$$PermissionFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$PermissionFailureImpl>
    implements _$$PermissionFailureImplCopyWith<$Res> {
  __$$PermissionFailureImplCopyWithImpl(
    _$PermissionFailureImpl _value,
    $Res Function(_$PermissionFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? permission = freezed}) {
    return _then(
      _$PermissionFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        permission: freezed == permission
            ? _value.permission
            : permission // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PermissionFailureImpl implements PermissionFailure {
  const _$PermissionFailureImpl({required this.message, this.permission});

  @override
  final String message;
  @override
  final String? permission;

  @override
  String toString() {
    return 'Failure.permission(message: $message, permission: $permission)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermissionFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.permission, permission) ||
                other.permission == permission));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, permission);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      __$$PermissionFailureImplCopyWithImpl<_$PermissionFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return permission(message, this.permission);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return permission?.call(message, this.permission);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(message, this.permission);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return permission(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return permission?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (permission != null) {
      return permission(this);
    }
    return orElse();
  }
}

abstract class PermissionFailure implements Failure {
  const factory PermissionFailure({
    required final String message,
    final String? permission,
  }) = _$PermissionFailureImpl;

  @override
  String get message;
  String? get permission;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermissionFailureImplCopyWith<_$PermissionFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UnknownFailureImplCopyWith<$Res>
    implements $FailureCopyWith<$Res> {
  factory _$$UnknownFailureImplCopyWith(
    _$UnknownFailureImpl value,
    $Res Function(_$UnknownFailureImpl) then,
  ) = __$$UnknownFailureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, Object? originalError});
}

/// @nodoc
class __$$UnknownFailureImplCopyWithImpl<$Res>
    extends _$FailureCopyWithImpl<$Res, _$UnknownFailureImpl>
    implements _$$UnknownFailureImplCopyWith<$Res> {
  __$$UnknownFailureImplCopyWithImpl(
    _$UnknownFailureImpl _value,
    $Res Function(_$UnknownFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? originalError = freezed}) {
    return _then(
      _$UnknownFailureImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        originalError: freezed == originalError
            ? _value.originalError
            : originalError,
      ),
    );
  }
}

/// @nodoc

class _$UnknownFailureImpl implements UnknownFailure {
  const _$UnknownFailureImpl({required this.message, this.originalError});

  @override
  final String message;
  @override
  final Object? originalError;

  @override
  String toString() {
    return 'Failure.unknown(message: $message, originalError: $originalError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownFailureImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other.originalError,
              originalError,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(originalError),
  );

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      __$$UnknownFailureImplCopyWithImpl<_$UnknownFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message, int? statusCode, String? endpoint)
    network,
    required TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )
    validation,
    required TResult Function(String message, int? statusCode, String? endpoint)
    server,
    required TResult Function(String message, String? key) cache,
    required TResult Function(String message, bool requiresLogin) unauthorized,
    required TResult Function(String message, String? resource) notFound,
    required TResult Function(String message, Duration? duration) timeout,
    required TResult Function(
      String message,
      String? fileName,
      int? fileSizeBytes,
    )
    fileUpload,
    required TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )
    documentProcessing,
    required TResult Function(
      String message,
      String? flightNumber,
      String? reason,
    )
    compensation,
    required TResult Function(String message, String? permission) permission,
    required TResult Function(String message, Object? originalError) unknown,
  }) {
    return unknown(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult? Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult? Function(String message, int? statusCode, String? endpoint)?
    server,
    TResult? Function(String message, String? key)? cache,
    TResult? Function(String message, bool requiresLogin)? unauthorized,
    TResult? Function(String message, String? resource)? notFound,
    TResult? Function(String message, Duration? duration)? timeout,
    TResult? Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult? Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult? Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult? Function(String message, String? permission)? permission,
    TResult? Function(String message, Object? originalError)? unknown,
  }) {
    return unknown?.call(message, originalError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message, int? statusCode, String? endpoint)?
    network,
    TResult Function(
      String message,
      Map<String, String>? fieldErrors,
      String? field,
    )?
    validation,
    TResult Function(String message, int? statusCode, String? endpoint)? server,
    TResult Function(String message, String? key)? cache,
    TResult Function(String message, bool requiresLogin)? unauthorized,
    TResult Function(String message, String? resource)? notFound,
    TResult Function(String message, Duration? duration)? timeout,
    TResult Function(String message, String? fileName, int? fileSizeBytes)?
    fileUpload,
    TResult Function(
      String message,
      String? documentId,
      String? processingStep,
    )?
    documentProcessing,
    TResult Function(String message, String? flightNumber, String? reason)?
    compensation,
    TResult Function(String message, String? permission)? permission,
    TResult Function(String message, Object? originalError)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(message, originalError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NetworkFailure value) network,
    required TResult Function(ValidationFailure value) validation,
    required TResult Function(ServerFailure value) server,
    required TResult Function(CacheFailure value) cache,
    required TResult Function(UnauthorizedFailure value) unauthorized,
    required TResult Function(NotFoundFailure value) notFound,
    required TResult Function(TimeoutFailure value) timeout,
    required TResult Function(FileUploadFailure value) fileUpload,
    required TResult Function(DocumentProcessingFailure value)
    documentProcessing,
    required TResult Function(CompensationFailure value) compensation,
    required TResult Function(PermissionFailure value) permission,
    required TResult Function(UnknownFailure value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NetworkFailure value)? network,
    TResult? Function(ValidationFailure value)? validation,
    TResult? Function(ServerFailure value)? server,
    TResult? Function(CacheFailure value)? cache,
    TResult? Function(UnauthorizedFailure value)? unauthorized,
    TResult? Function(NotFoundFailure value)? notFound,
    TResult? Function(TimeoutFailure value)? timeout,
    TResult? Function(FileUploadFailure value)? fileUpload,
    TResult? Function(DocumentProcessingFailure value)? documentProcessing,
    TResult? Function(CompensationFailure value)? compensation,
    TResult? Function(PermissionFailure value)? permission,
    TResult? Function(UnknownFailure value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NetworkFailure value)? network,
    TResult Function(ValidationFailure value)? validation,
    TResult Function(ServerFailure value)? server,
    TResult Function(CacheFailure value)? cache,
    TResult Function(UnauthorizedFailure value)? unauthorized,
    TResult Function(NotFoundFailure value)? notFound,
    TResult Function(TimeoutFailure value)? timeout,
    TResult Function(FileUploadFailure value)? fileUpload,
    TResult Function(DocumentProcessingFailure value)? documentProcessing,
    TResult Function(CompensationFailure value)? compensation,
    TResult Function(PermissionFailure value)? permission,
    TResult Function(UnknownFailure value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownFailure implements Failure {
  const factory UnknownFailure({
    required final String message,
    final Object? originalError,
  }) = _$UnknownFailureImpl;

  @override
  String get message;
  Object? get originalError;

  /// Create a copy of Failure
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownFailureImplCopyWith<_$UnknownFailureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
