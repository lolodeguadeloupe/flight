// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'claim.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ClaimExpense {
  String get id => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  DateTime? get incurredAt => throw _privateConstructorUsedError;
  String? get documentId => throw _privateConstructorUsedError;

  /// Create a copy of ClaimExpense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClaimExpenseCopyWith<ClaimExpense> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimExpenseCopyWith<$Res> {
  factory $ClaimExpenseCopyWith(
    ClaimExpense value,
    $Res Function(ClaimExpense) then,
  ) = _$ClaimExpenseCopyWithImpl<$Res, ClaimExpense>;
  @useResult
  $Res call({
    String id,
    String category,
    String description,
    double amount,
    String currency,
    DateTime? incurredAt,
    String? documentId,
  });
}

/// @nodoc
class _$ClaimExpenseCopyWithImpl<$Res, $Val extends ClaimExpense>
    implements $ClaimExpenseCopyWith<$Res> {
  _$ClaimExpenseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClaimExpense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? description = null,
    Object? amount = null,
    Object? currency = null,
    Object? incurredAt = freezed,
    Object? documentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as double,
            currency: null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String,
            incurredAt: freezed == incurredAt
                ? _value.incurredAt
                : incurredAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            documentId: freezed == documentId
                ? _value.documentId
                : documentId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ClaimExpenseImplCopyWith<$Res>
    implements $ClaimExpenseCopyWith<$Res> {
  factory _$$ClaimExpenseImplCopyWith(
    _$ClaimExpenseImpl value,
    $Res Function(_$ClaimExpenseImpl) then,
  ) = __$$ClaimExpenseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String category,
    String description,
    double amount,
    String currency,
    DateTime? incurredAt,
    String? documentId,
  });
}

/// @nodoc
class __$$ClaimExpenseImplCopyWithImpl<$Res>
    extends _$ClaimExpenseCopyWithImpl<$Res, _$ClaimExpenseImpl>
    implements _$$ClaimExpenseImplCopyWith<$Res> {
  __$$ClaimExpenseImplCopyWithImpl(
    _$ClaimExpenseImpl _value,
    $Res Function(_$ClaimExpenseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ClaimExpense
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? description = null,
    Object? amount = null,
    Object? currency = null,
    Object? incurredAt = freezed,
    Object? documentId = freezed,
  }) {
    return _then(
      _$ClaimExpenseImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as double,
        currency: null == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String,
        incurredAt: freezed == incurredAt
            ? _value.incurredAt
            : incurredAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        documentId: freezed == documentId
            ? _value.documentId
            : documentId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ClaimExpenseImpl implements _ClaimExpense {
  const _$ClaimExpenseImpl({
    required this.id,
    required this.category,
    required this.description,
    required this.amount,
    required this.currency,
    this.incurredAt,
    this.documentId,
  });

  @override
  final String id;
  @override
  final String category;
  @override
  final String description;
  @override
  final double amount;
  @override
  final String currency;
  @override
  final DateTime? incurredAt;
  @override
  final String? documentId;

  @override
  String toString() {
    return 'ClaimExpense(id: $id, category: $category, description: $description, amount: $amount, currency: $currency, incurredAt: $incurredAt, documentId: $documentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimExpenseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.incurredAt, incurredAt) ||
                other.incurredAt == incurredAt) &&
            (identical(other.documentId, documentId) ||
                other.documentId == documentId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    category,
    description,
    amount,
    currency,
    incurredAt,
    documentId,
  );

  /// Create a copy of ClaimExpense
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimExpenseImplCopyWith<_$ClaimExpenseImpl> get copyWith =>
      __$$ClaimExpenseImplCopyWithImpl<_$ClaimExpenseImpl>(this, _$identity);
}

abstract class _ClaimExpense implements ClaimExpense {
  const factory _ClaimExpense({
    required final String id,
    required final String category,
    required final String description,
    required final double amount,
    required final String currency,
    final DateTime? incurredAt,
    final String? documentId,
  }) = _$ClaimExpenseImpl;

  @override
  String get id;
  @override
  String get category;
  @override
  String get description;
  @override
  double get amount;
  @override
  String get currency;
  @override
  DateTime? get incurredAt;
  @override
  String? get documentId;

  /// Create a copy of ClaimExpense
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimExpenseImplCopyWith<_$ClaimExpenseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Claim {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;
  Flight get flight => throw _privateConstructorUsedError;
  ClaimType get claimType => throw _privateConstructorUsedError;
  ClaimStatus get status => throw _privateConstructorUsedError;
  DateTime get submissionDate => throw _privateConstructorUsedError;
  DateTime? get lastUpdateDate => throw _privateConstructorUsedError;
  String? get referenceNumber => throw _privateConstructorUsedError;
  double? get requestedAmount => throw _privateConstructorUsedError;
  double? get approvedAmount => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  List<Document> get attachments => throw _privateConstructorUsedError;
  List<ClaimExpense> get expenses => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get rejectionReason => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime? get processedAt => throw _privateConstructorUsedError;
  String? get processedBy => throw _privateConstructorUsedError;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClaimCopyWith<Claim> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClaimCopyWith<$Res> {
  factory $ClaimCopyWith(Claim value, $Res Function(Claim) then) =
      _$ClaimCopyWithImpl<$Res, Claim>;
  @useResult
  $Res call({
    String id,
    String userId,
    User user,
    Flight flight,
    ClaimType claimType,
    ClaimStatus status,
    DateTime submissionDate,
    DateTime? lastUpdateDate,
    String? referenceNumber,
    double? requestedAmount,
    double? approvedAmount,
    String? currency,
    List<Document> attachments,
    List<ClaimExpense> expenses,
    String? description,
    String? rejectionReason,
    Map<String, dynamic>? metadata,
    DateTime? processedAt,
    String? processedBy,
  });

  $UserCopyWith<$Res> get user;
  $FlightCopyWith<$Res> get flight;
}

/// @nodoc
class _$ClaimCopyWithImpl<$Res, $Val extends Claim>
    implements $ClaimCopyWith<$Res> {
  _$ClaimCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? user = null,
    Object? flight = null,
    Object? claimType = null,
    Object? status = null,
    Object? submissionDate = null,
    Object? lastUpdateDate = freezed,
    Object? referenceNumber = freezed,
    Object? requestedAmount = freezed,
    Object? approvedAmount = freezed,
    Object? currency = freezed,
    Object? attachments = null,
    Object? expenses = null,
    Object? description = freezed,
    Object? rejectionReason = freezed,
    Object? metadata = freezed,
    Object? processedAt = freezed,
    Object? processedBy = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as User,
            flight: null == flight
                ? _value.flight
                : flight // ignore: cast_nullable_to_non_nullable
                      as Flight,
            claimType: null == claimType
                ? _value.claimType
                : claimType // ignore: cast_nullable_to_non_nullable
                      as ClaimType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ClaimStatus,
            submissionDate: null == submissionDate
                ? _value.submissionDate
                : submissionDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lastUpdateDate: freezed == lastUpdateDate
                ? _value.lastUpdateDate
                : lastUpdateDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            referenceNumber: freezed == referenceNumber
                ? _value.referenceNumber
                : referenceNumber // ignore: cast_nullable_to_non_nullable
                      as String?,
            requestedAmount: freezed == requestedAmount
                ? _value.requestedAmount
                : requestedAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            approvedAmount: freezed == approvedAmount
                ? _value.approvedAmount
                : approvedAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            currency: freezed == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                      as String?,
            attachments: null == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<Document>,
            expenses: null == expenses
                ? _value.expenses
                : expenses // ignore: cast_nullable_to_non_nullable
                      as List<ClaimExpense>,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            rejectionReason: freezed == rejectionReason
                ? _value.rejectionReason
                : rejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            processedAt: freezed == processedAt
                ? _value.processedAt
                : processedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            processedBy: freezed == processedBy
                ? _value.processedBy
                : processedBy // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FlightCopyWith<$Res> get flight {
    return $FlightCopyWith<$Res>(_value.flight, (value) {
      return _then(_value.copyWith(flight: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ClaimImplCopyWith<$Res> implements $ClaimCopyWith<$Res> {
  factory _$$ClaimImplCopyWith(
    _$ClaimImpl value,
    $Res Function(_$ClaimImpl) then,
  ) = __$$ClaimImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    User user,
    Flight flight,
    ClaimType claimType,
    ClaimStatus status,
    DateTime submissionDate,
    DateTime? lastUpdateDate,
    String? referenceNumber,
    double? requestedAmount,
    double? approvedAmount,
    String? currency,
    List<Document> attachments,
    List<ClaimExpense> expenses,
    String? description,
    String? rejectionReason,
    Map<String, dynamic>? metadata,
    DateTime? processedAt,
    String? processedBy,
  });

  @override
  $UserCopyWith<$Res> get user;
  @override
  $FlightCopyWith<$Res> get flight;
}

/// @nodoc
class __$$ClaimImplCopyWithImpl<$Res>
    extends _$ClaimCopyWithImpl<$Res, _$ClaimImpl>
    implements _$$ClaimImplCopyWith<$Res> {
  __$$ClaimImplCopyWithImpl(
    _$ClaimImpl _value,
    $Res Function(_$ClaimImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? user = null,
    Object? flight = null,
    Object? claimType = null,
    Object? status = null,
    Object? submissionDate = null,
    Object? lastUpdateDate = freezed,
    Object? referenceNumber = freezed,
    Object? requestedAmount = freezed,
    Object? approvedAmount = freezed,
    Object? currency = freezed,
    Object? attachments = null,
    Object? expenses = null,
    Object? description = freezed,
    Object? rejectionReason = freezed,
    Object? metadata = freezed,
    Object? processedAt = freezed,
    Object? processedBy = freezed,
  }) {
    return _then(
      _$ClaimImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as User,
        flight: null == flight
            ? _value.flight
            : flight // ignore: cast_nullable_to_non_nullable
                  as Flight,
        claimType: null == claimType
            ? _value.claimType
            : claimType // ignore: cast_nullable_to_non_nullable
                  as ClaimType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ClaimStatus,
        submissionDate: null == submissionDate
            ? _value.submissionDate
            : submissionDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lastUpdateDate: freezed == lastUpdateDate
            ? _value.lastUpdateDate
            : lastUpdateDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        referenceNumber: freezed == referenceNumber
            ? _value.referenceNumber
            : referenceNumber // ignore: cast_nullable_to_non_nullable
                  as String?,
        requestedAmount: freezed == requestedAmount
            ? _value.requestedAmount
            : requestedAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        approvedAmount: freezed == approvedAmount
            ? _value.approvedAmount
            : approvedAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        currency: freezed == currency
            ? _value.currency
            : currency // ignore: cast_nullable_to_non_nullable
                  as String?,
        attachments: null == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<Document>,
        expenses: null == expenses
            ? _value._expenses
            : expenses // ignore: cast_nullable_to_non_nullable
                  as List<ClaimExpense>,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        rejectionReason: freezed == rejectionReason
            ? _value.rejectionReason
            : rejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        processedAt: freezed == processedAt
            ? _value.processedAt
            : processedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        processedBy: freezed == processedBy
            ? _value.processedBy
            : processedBy // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ClaimImpl extends _Claim {
  const _$ClaimImpl({
    required this.id,
    required this.userId,
    required this.user,
    required this.flight,
    required this.claimType,
    required this.status,
    required this.submissionDate,
    this.lastUpdateDate,
    this.referenceNumber,
    this.requestedAmount,
    this.approvedAmount,
    this.currency,
    final List<Document> attachments = const [],
    final List<ClaimExpense> expenses = const [],
    this.description,
    this.rejectionReason,
    final Map<String, dynamic>? metadata,
    this.processedAt,
    this.processedBy,
  }) : _attachments = attachments,
       _expenses = expenses,
       _metadata = metadata,
       super._();

  @override
  final String id;
  @override
  final String userId;
  @override
  final User user;
  @override
  final Flight flight;
  @override
  final ClaimType claimType;
  @override
  final ClaimStatus status;
  @override
  final DateTime submissionDate;
  @override
  final DateTime? lastUpdateDate;
  @override
  final String? referenceNumber;
  @override
  final double? requestedAmount;
  @override
  final double? approvedAmount;
  @override
  final String? currency;
  final List<Document> _attachments;
  @override
  @JsonKey()
  List<Document> get attachments {
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_attachments);
  }

  final List<ClaimExpense> _expenses;
  @override
  @JsonKey()
  List<ClaimExpense> get expenses {
    if (_expenses is EqualUnmodifiableListView) return _expenses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_expenses);
  }

  @override
  final String? description;
  @override
  final String? rejectionReason;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime? processedAt;
  @override
  final String? processedBy;

  @override
  String toString() {
    return 'Claim(id: $id, userId: $userId, user: $user, flight: $flight, claimType: $claimType, status: $status, submissionDate: $submissionDate, lastUpdateDate: $lastUpdateDate, referenceNumber: $referenceNumber, requestedAmount: $requestedAmount, approvedAmount: $approvedAmount, currency: $currency, attachments: $attachments, expenses: $expenses, description: $description, rejectionReason: $rejectionReason, metadata: $metadata, processedAt: $processedAt, processedBy: $processedBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.flight, flight) || other.flight == flight) &&
            (identical(other.claimType, claimType) ||
                other.claimType == claimType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.submissionDate, submissionDate) ||
                other.submissionDate == submissionDate) &&
            (identical(other.lastUpdateDate, lastUpdateDate) ||
                other.lastUpdateDate == lastUpdateDate) &&
            (identical(other.referenceNumber, referenceNumber) ||
                other.referenceNumber == referenceNumber) &&
            (identical(other.requestedAmount, requestedAmount) ||
                other.requestedAmount == requestedAmount) &&
            (identical(other.approvedAmount, approvedAmount) ||
                other.approvedAmount == approvedAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            const DeepCollectionEquality().equals(other._expenses, _expenses) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rejectionReason, rejectionReason) ||
                other.rejectionReason == rejectionReason) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.processedAt, processedAt) ||
                other.processedAt == processedAt) &&
            (identical(other.processedBy, processedBy) ||
                other.processedBy == processedBy));
  }

  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    userId,
    user,
    flight,
    claimType,
    status,
    submissionDate,
    lastUpdateDate,
    referenceNumber,
    requestedAmount,
    approvedAmount,
    currency,
    const DeepCollectionEquality().hash(_attachments),
    const DeepCollectionEquality().hash(_expenses),
    description,
    rejectionReason,
    const DeepCollectionEquality().hash(_metadata),
    processedAt,
    processedBy,
  ]);

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimImplCopyWith<_$ClaimImpl> get copyWith =>
      __$$ClaimImplCopyWithImpl<_$ClaimImpl>(this, _$identity);
}

abstract class _Claim extends Claim {
  const factory _Claim({
    required final String id,
    required final String userId,
    required final User user,
    required final Flight flight,
    required final ClaimType claimType,
    required final ClaimStatus status,
    required final DateTime submissionDate,
    final DateTime? lastUpdateDate,
    final String? referenceNumber,
    final double? requestedAmount,
    final double? approvedAmount,
    final String? currency,
    final List<Document> attachments,
    final List<ClaimExpense> expenses,
    final String? description,
    final String? rejectionReason,
    final Map<String, dynamic>? metadata,
    final DateTime? processedAt,
    final String? processedBy,
  }) = _$ClaimImpl;
  const _Claim._() : super._();

  @override
  String get id;
  @override
  String get userId;
  @override
  User get user;
  @override
  Flight get flight;
  @override
  ClaimType get claimType;
  @override
  ClaimStatus get status;
  @override
  DateTime get submissionDate;
  @override
  DateTime? get lastUpdateDate;
  @override
  String? get referenceNumber;
  @override
  double? get requestedAmount;
  @override
  double? get approvedAmount;
  @override
  String? get currency;
  @override
  List<Document> get attachments;
  @override
  List<ClaimExpense> get expenses;
  @override
  String? get description;
  @override
  String? get rejectionReason;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime? get processedAt;
  @override
  String? get processedBy;

  /// Create a copy of Claim
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClaimImplCopyWith<_$ClaimImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
