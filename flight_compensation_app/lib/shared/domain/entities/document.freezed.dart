// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'document.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Document {
  String get id => throw _privateConstructorUsedError;
  DocumentType get type => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  String? get localPath => throw _privateConstructorUsedError;
  int get fileSizeBytes => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;
  DateTime get uploadedAt => throw _privateConstructorUsedError;
  DocumentStatus get status => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  Map<String, dynamic>? get extractedData => throw _privateConstructorUsedError;
  double? get confidenceScore => throw _privateConstructorUsedError;
  DateTime? get processedAt => throw _privateConstructorUsedError;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DocumentCopyWith<Document> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DocumentCopyWith<$Res> {
  factory $DocumentCopyWith(Document value, $Res Function(Document) then) =
      _$DocumentCopyWithImpl<$Res, Document>;
  @useResult
  $Res call({
    String id,
    DocumentType type,
    String fileName,
    String url,
    String? localPath,
    int fileSizeBytes,
    String mimeType,
    DateTime uploadedAt,
    DocumentStatus status,
    String? rejectionReason,
    Map<String, dynamic>? extractedData,
    double? confidenceScore,
    DateTime? processedAt,
  });
}

/// @nodoc
class _$DocumentCopyWithImpl<$Res, $Val extends Document>
    implements $DocumentCopyWith<$Res> {
  _$DocumentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? fileName = null,
    Object? url = null,
    Object? localPath = freezed,
    Object? fileSizeBytes = null,
    Object? mimeType = null,
    Object? uploadedAt = null,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? extractedData = freezed,
    Object? confidenceScore = freezed,
    Object? processedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as DocumentType,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            localPath: freezed == localPath
                ? _value.localPath
                : localPath // ignore: cast_nullable_to_non_nullable
                      as String?,
            fileSizeBytes: null == fileSizeBytes
                ? _value.fileSizeBytes
                : fileSizeBytes // ignore: cast_nullable_to_non_nullable
                      as int,
            mimeType: null == mimeType
                ? _value.mimeType
                : mimeType // ignore: cast_nullable_to_non_nullable
                      as String,
            uploadedAt: null == uploadedAt
                ? _value.uploadedAt
                : uploadedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as DocumentStatus,
            rejectionReason: freezed == rejectionReason
                ? _value.rejectionReason
                : rejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            extractedData: freezed == extractedData
                ? _value.extractedData
                : extractedData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            confidenceScore: freezed == confidenceScore
                ? _value.confidenceScore
                : confidenceScore // ignore: cast_nullable_to_non_nullable
                      as double?,
            processedAt: freezed == processedAt
                ? _value.processedAt
                : processedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DocumentImplCopyWith<$Res>
    implements $DocumentCopyWith<$Res> {
  factory _$$DocumentImplCopyWith(
    _$DocumentImpl value,
    $Res Function(_$DocumentImpl) then,
  ) = __$$DocumentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DocumentType type,
    String fileName,
    String url,
    String? localPath,
    int fileSizeBytes,
    String mimeType,
    DateTime uploadedAt,
    DocumentStatus status,
    String? rejectionReason,
    Map<String, dynamic>? extractedData,
    double? confidenceScore,
    DateTime? processedAt,
  });
}

/// @nodoc
class __$$DocumentImplCopyWithImpl<$Res>
    extends _$DocumentCopyWithImpl<$Res, _$DocumentImpl>
    implements _$$DocumentImplCopyWith<$Res> {
  __$$DocumentImplCopyWithImpl(
    _$DocumentImpl _value,
    $Res Function(_$DocumentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? fileName = null,
    Object? url = null,
    Object? localPath = freezed,
    Object? fileSizeBytes = null,
    Object? mimeType = null,
    Object? uploadedAt = null,
    Object? status = null,
    Object? rejectionReason = freezed,
    Object? extractedData = freezed,
    Object? confidenceScore = freezed,
    Object? processedAt = freezed,
  }) {
    return _then(
      _$DocumentImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as DocumentType,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        localPath: freezed == localPath
            ? _value.localPath
            : localPath // ignore: cast_nullable_to_non_nullable
                  as String?,
        fileSizeBytes: null == fileSizeBytes
            ? _value.fileSizeBytes
            : fileSizeBytes // ignore: cast_nullable_to_non_nullable
                  as int,
        mimeType: null == mimeType
            ? _value.mimeType
            : mimeType // ignore: cast_nullable_to_non_nullable
                  as String,
        uploadedAt: null == uploadedAt
            ? _value.uploadedAt
            : uploadedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as DocumentStatus,
        rejectionReason: freezed == rejectionReason
            ? _value.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        extractedData: freezed == extractedData
            ? _value._extractedData
            : extractedData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        confidenceScore: freezed == confidenceScore
            ? _value.confidenceScore
            : confidenceScore // ignore: cast_nullable_to_non_nullable
                  as double?,
        processedAt: freezed == processedAt
            ? _value.processedAt
            : processedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$DocumentImpl extends _Document {
  const _$DocumentImpl({
    required this.id,
    required this.type,
    required this.fileName,
    required this.url,
    this.localPath,
    required this.fileSizeBytes,
    required this.mimeType,
    required this.uploadedAt,
    this.status = DocumentStatus.pending,
    this.rejectionReason,
    final Map<String, dynamic>? extractedData,
    this.confidenceScore,
    this.processedAt,
  }) : _extractedData = extractedData,
       super._();

  @override
  final String id;
  @override
  final DocumentType type;
  @override
  final String fileName;
  @override
  final String url;
  @override
  final String? localPath;
  @override
  final int fileSizeBytes;
  @override
  final String mimeType;
  @override
  final DateTime uploadedAt;
  @override
  @JsonKey()
  final DocumentStatus status;
  @override
  final String? rejectionReason;
  final Map<String, dynamic>? _extractedData;
  @override
  Map<String, dynamic>? get extractedData {
    final value = _extractedData;
    if (value == null) return null;
    if (_extractedData is EqualUnmodifiableMapView) return _extractedData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final double? confidenceScore;
  @override
  final DateTime? processedAt;

  @override
  String toString() {
    return 'Document(id: $id, type: $type, fileName: $fileName, url: $url, localPath: $localPath, fileSizeBytes: $fileSizeBytes, mimeType: $mimeType, uploadedAt: $uploadedAt, status: $status, rejectionReason: $rejectionReason, extractedData: $extractedData, confidenceScore: $confidenceScore, processedAt: $processedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DocumentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.fileSizeBytes, fileSizeBytes) ||
                other.fileSizeBytes == fileSizeBytes) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            (identical(other.uploadedAt, uploadedAt) ||
                other.uploadedAt == uploadedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            const DeepCollectionEquality().equals(
              other._extractedData,
              _extractedData,
            ) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    fileName,
    url,
    localPath,
    fileSizeBytes,
    mimeType,
    uploadedAt,
    status,
    rejectionReason,
    const DeepCollectionEquality().hash(_extractedData),
    confidenceScore,
    processedAt,
  );

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      __$$DocumentImplCopyWithImpl<_$DocumentImpl>(this, _$identity);
}

abstract class _Document extends Document {
  const factory _Document({
    required final String id,
    required final DocumentType type,
    required final String fileName,
    required final String url,
    final String? localPath,
    required final int fileSizeBytes,
    required final String mimeType,
    required final DateTime uploadedAt,
    final DocumentStatus status,
    final String? rejectionReason,
    final Map<String, dynamic>? extractedData,
    final double? confidenceScore,
    final DateTime? processedAt,
  }) = _$DocumentImpl;
  const _Document._() : super._();

  @override
  String get id;
  @override
  DocumentType get type;
  @override
  String get fileName;
  @override
  String get url;
  @override
  String? get localPath;
  @override
  int get fileSizeBytes;
  @override
  String get mimeType;
  @override
  DateTime get uploadedAt;
  @override
  DocumentStatus get status;
  @override
  String? get rejectionReason;
  @override
  Map<String, dynamic>? get extractedData;
  @override
  double? get confidenceScore;
  @override
  DateTime? get processedAt;

  /// Create a copy of Document
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DocumentImplCopyWith<_$DocumentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
