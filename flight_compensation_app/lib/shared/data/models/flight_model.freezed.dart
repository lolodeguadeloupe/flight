// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flight_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AirportModel _$AirportModelFromJson(Map<String, dynamic> json) {
  return _AirportModel.fromJson(json);
}

/// @nodoc
mixin _$AirportModel {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this AirportModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AirportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AirportModelCopyWith<AirportModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirportModelCopyWith<$Res> {
  factory $AirportModelCopyWith(
    AirportModel value,
    $Res Function(AirportModel) then,
  ) = _$AirportModelCopyWithImpl<$Res, AirportModel>;
  @useResult
  $Res call({
    String code,
    String name,
    String city,
    String country,
    double? latitude,
    double? longitude,
  });
}

/// @nodoc
class _$AirportModelCopyWithImpl<$Res, $Val extends AirportModel>
    implements $AirportModelCopyWith<$Res> {
  _$AirportModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AirportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? city = null,
    Object? country = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            city: null == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String,
            country: null == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: freezed == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double?,
            longitude: freezed == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AirportModelImplCopyWith<$Res>
    implements $AirportModelCopyWith<$Res> {
  factory _$$AirportModelImplCopyWith(
    _$AirportModelImpl value,
    $Res Function(_$AirportModelImpl) then,
  ) = __$$AirportModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String code,
    String name,
    String city,
    String country,
    double? latitude,
    double? longitude,
  });
}

/// @nodoc
class __$$AirportModelImplCopyWithImpl<$Res>
    extends _$AirportModelCopyWithImpl<$Res, _$AirportModelImpl>
    implements _$$AirportModelImplCopyWith<$Res> {
  __$$AirportModelImplCopyWithImpl(
    _$AirportModelImpl _value,
    $Res Function(_$AirportModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AirportModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? name = null,
    Object? city = null,
    Object? country = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(
      _$AirportModelImpl(
        code: null == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        city: null == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String,
        country: null == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: freezed == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double?,
        longitude: freezed == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AirportModelImpl extends _AirportModel {
  const _$AirportModelImpl({
    required this.code,
    required this.name,
    required this.city,
    required this.country,
    this.latitude,
    this.longitude,
  }) : super._();

  factory _$AirportModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AirportModelImplFromJson(json);

  @override
  final String code;
  @override
  final String name;
  @override
  final String city;
  @override
  final String country;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'AirportModel(code: $code, name: $name, city: $city, country: $country, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirportModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, code, name, city, country, latitude, longitude);

  /// Create a copy of AirportModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AirportModelImplCopyWith<_$AirportModelImpl> get copyWith =>
      __$$AirportModelImplCopyWithImpl<_$AirportModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AirportModelImplToJson(this);
  }
}

abstract class _AirportModel extends AirportModel {
  const factory _AirportModel({
    required final String code,
    required final String name,
    required final String city,
    required final String country,
    final double? latitude,
    final double? longitude,
  }) = _$AirportModelImpl;
  const _AirportModel._() : super._();

  factory _AirportModel.fromJson(Map<String, dynamic> json) =
      _$AirportModelImpl.fromJson;

  @override
  String get code;
  @override
  String get name;
  @override
  String get city;
  @override
  String get country;
  @override
  double? get latitude;
  @override
  double? get longitude;

  /// Create a copy of AirportModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirportModelImplCopyWith<_$AirportModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FlightModel _$FlightModelFromJson(Map<String, dynamic> json) {
  return _FlightModel.fromJson(json);
}

/// @nodoc
mixin _$FlightModel {
  String get flightNumber => throw _privateConstructorUsedError;
  String get airline => throw _privateConstructorUsedError;
  AirportModel get departureAirport => throw _privateConstructorUsedError;
  AirportModel get arrivalAirport => throw _privateConstructorUsedError;
  DateTime get scheduledDeparture => throw _privateConstructorUsedError;
  DateTime get scheduledArrival => throw _privateConstructorUsedError;
  DateTime? get actualDeparture => throw _privateConstructorUsedError;
  DateTime? get actualArrival => throw _privateConstructorUsedError;
  DelayReason? get delayReason => throw _privateConstructorUsedError;
  String? get delayReasonDescription => throw _privateConstructorUsedError;
  double get distanceKm => throw _privateConstructorUsedError;
  FlightJurisdiction get jurisdiction => throw _privateConstructorUsedError;
  double? get compensationAmount => throw _privateConstructorUsedError;
  String? get aircraftType => throw _privateConstructorUsedError;
  String? get gate => throw _privateConstructorUsedError;
  String? get seat => throw _privateConstructorUsedError;

  /// Serializes this FlightModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FlightModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlightModelCopyWith<FlightModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlightModelCopyWith<$Res> {
  factory $FlightModelCopyWith(
    FlightModel value,
    $Res Function(FlightModel) then,
  ) = _$FlightModelCopyWithImpl<$Res, FlightModel>;
  @useResult
  $Res call({
    String flightNumber,
    String airline,
    AirportModel departureAirport,
    AirportModel arrivalAirport,
    DateTime scheduledDeparture,
    DateTime scheduledArrival,
    DateTime? actualDeparture,
    DateTime? actualArrival,
    DelayReason? delayReason,
    String? delayReasonDescription,
    double distanceKm,
    FlightJurisdiction jurisdiction,
    double? compensationAmount,
    String? aircraftType,
    String? gate,
    String? seat,
  });

  $AirportModelCopyWith<$Res> get departureAirport;
  $AirportModelCopyWith<$Res> get arrivalAirport;
}

/// @nodoc
class _$FlightModelCopyWithImpl<$Res, $Val extends FlightModel>
    implements $FlightModelCopyWith<$Res> {
  _$FlightModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FlightModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flightNumber = null,
    Object? airline = null,
    Object? departureAirport = null,
    Object? arrivalAirport = null,
    Object? scheduledDeparture = null,
    Object? scheduledArrival = null,
    Object? actualDeparture = freezed,
    Object? actualArrival = freezed,
    Object? delayReason = freezed,
    Object? delayReasonDescription = freezed,
    Object? distanceKm = null,
    Object? jurisdiction = null,
    Object? compensationAmount = freezed,
    Object? aircraftType = freezed,
    Object? gate = freezed,
    Object? seat = freezed,
  }) {
    return _then(
      _value.copyWith(
            flightNumber: null == flightNumber
                ? _value.flightNumber
                : flightNumber // ignore: cast_nullable_to_non_nullable
                      as String,
            airline: null == airline
                ? _value.airline
                : airline // ignore: cast_nullable_to_non_nullable
                      as String,
            departureAirport: null == departureAirport
                ? _value.departureAirport
                : departureAirport // ignore: cast_nullable_to_non_nullable
                      as AirportModel,
            arrivalAirport: null == arrivalAirport
                ? _value.arrivalAirport
                : arrivalAirport // ignore: cast_nullable_to_non_nullable
                      as AirportModel,
            scheduledDeparture: null == scheduledDeparture
                ? _value.scheduledDeparture
                : scheduledDeparture // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            scheduledArrival: null == scheduledArrival
                ? _value.scheduledArrival
                : scheduledArrival // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            actualDeparture: freezed == actualDeparture
                ? _value.actualDeparture
                : actualDeparture // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            actualArrival: freezed == actualArrival
                ? _value.actualArrival
                : actualArrival // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            delayReason: freezed == delayReason
                ? _value.delayReason
                : delayReason // ignore: cast_nullable_to_non_nullable
                      as DelayReason?,
            delayReasonDescription: freezed == delayReasonDescription
                ? _value.delayReasonDescription
                : delayReasonDescription // ignore: cast_nullable_to_non_nullable
                      as String?,
            distanceKm: null == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double,
            jurisdiction: null == jurisdiction
                ? _value.jurisdiction
                : jurisdiction // ignore: cast_nullable_to_non_nullable
                      as FlightJurisdiction,
            compensationAmount: freezed == compensationAmount
                ? _value.compensationAmount
                : compensationAmount // ignore: cast_nullable_to_non_nullable
                      as double?,
            aircraftType: freezed == aircraftType
                ? _value.aircraftType
                : aircraftType // ignore: cast_nullable_to_non_nullable
                      as String?,
            gate: freezed == gate
                ? _value.gate
                : gate // ignore: cast_nullable_to_non_nullable
                      as String?,
            seat: freezed == seat
                ? _value.seat
                : seat // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of FlightModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AirportModelCopyWith<$Res> get departureAirport {
    return $AirportModelCopyWith<$Res>(_value.departureAirport, (value) {
      return _then(_value.copyWith(departureAirport: value) as $Val);
    });
  }

  /// Create a copy of FlightModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AirportModelCopyWith<$Res> get arrivalAirport {
    return $AirportModelCopyWith<$Res>(_value.arrivalAirport, (value) {
      return _then(_value.copyWith(arrivalAirport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FlightModelImplCopyWith<$Res>
    implements $FlightModelCopyWith<$Res> {
  factory _$$FlightModelImplCopyWith(
    _$FlightModelImpl value,
    $Res Function(_$FlightModelImpl) then,
  ) = __$$FlightModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String flightNumber,
    String airline,
    AirportModel departureAirport,
    AirportModel arrivalAirport,
    DateTime scheduledDeparture,
    DateTime scheduledArrival,
    DateTime? actualDeparture,
    DateTime? actualArrival,
    DelayReason? delayReason,
    String? delayReasonDescription,
    double distanceKm,
    FlightJurisdiction jurisdiction,
    double? compensationAmount,
    String? aircraftType,
    String? gate,
    String? seat,
  });

  @override
  $AirportModelCopyWith<$Res> get departureAirport;
  @override
  $AirportModelCopyWith<$Res> get arrivalAirport;
}

/// @nodoc
class __$$FlightModelImplCopyWithImpl<$Res>
    extends _$FlightModelCopyWithImpl<$Res, _$FlightModelImpl>
    implements _$$FlightModelImplCopyWith<$Res> {
  __$$FlightModelImplCopyWithImpl(
    _$FlightModelImpl _value,
    $Res Function(_$FlightModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FlightModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? flightNumber = null,
    Object? airline = null,
    Object? departureAirport = null,
    Object? arrivalAirport = null,
    Object? scheduledDeparture = null,
    Object? scheduledArrival = null,
    Object? actualDeparture = freezed,
    Object? actualArrival = freezed,
    Object? delayReason = freezed,
    Object? delayReasonDescription = freezed,
    Object? distanceKm = null,
    Object? jurisdiction = null,
    Object? compensationAmount = freezed,
    Object? aircraftType = freezed,
    Object? gate = freezed,
    Object? seat = freezed,
  }) {
    return _then(
      _$FlightModelImpl(
        flightNumber: null == flightNumber
            ? _value.flightNumber
            : flightNumber // ignore: cast_nullable_to_non_nullable
                  as String,
        airline: null == airline
            ? _value.airline
            : airline // ignore: cast_nullable_to_non_nullable
                  as String,
        departureAirport: null == departureAirport
            ? _value.departureAirport
            : departureAirport // ignore: cast_nullable_to_non_nullable
                  as AirportModel,
        arrivalAirport: null == arrivalAirport
            ? _value.arrivalAirport
            : arrivalAirport // ignore: cast_nullable_to_non_nullable
                  as AirportModel,
        scheduledDeparture: null == scheduledDeparture
            ? _value.scheduledDeparture
            : scheduledDeparture // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        scheduledArrival: null == scheduledArrival
            ? _value.scheduledArrival
            : scheduledArrival // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        actualDeparture: freezed == actualDeparture
            ? _value.actualDeparture
            : actualDeparture // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        actualArrival: freezed == actualArrival
            ? _value.actualArrival
            : actualArrival // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        delayReason: freezed == delayReason
            ? _value.delayReason
            : delayReason // ignore: cast_nullable_to_non_nullable
                  as DelayReason?,
        delayReasonDescription: freezed == delayReasonDescription
            ? _value.delayReasonDescription
            : delayReasonDescription // ignore: cast_nullable_to_non_nullable
                  as String?,
        distanceKm: null == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double,
        jurisdiction: null == jurisdiction
            ? _value.jurisdiction
            : jurisdiction // ignore: cast_nullable_to_non_nullable
                  as FlightJurisdiction,
        compensationAmount: freezed == compensationAmount
            ? _value.compensationAmount
            : compensationAmount // ignore: cast_nullable_to_non_nullable
                  as double?,
        aircraftType: freezed == aircraftType
            ? _value.aircraftType
            : aircraftType // ignore: cast_nullable_to_non_nullable
                  as String?,
        gate: freezed == gate
            ? _value.gate
            : gate // ignore: cast_nullable_to_non_nullable
                  as String?,
        seat: freezed == seat
            ? _value.seat
            : seat // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FlightModelImpl extends _FlightModel {
  const _$FlightModelImpl({
    required this.flightNumber,
    required this.airline,
    required this.departureAirport,
    required this.arrivalAirport,
    required this.scheduledDeparture,
    required this.scheduledArrival,
    this.actualDeparture,
    this.actualArrival,
    this.delayReason,
    this.delayReasonDescription,
    required this.distanceKm,
    required this.jurisdiction,
    this.compensationAmount,
    this.aircraftType,
    this.gate,
    this.seat,
  }) : super._();

  factory _$FlightModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FlightModelImplFromJson(json);

  @override
  final String flightNumber;
  @override
  final String airline;
  @override
  final AirportModel departureAirport;
  @override
  final AirportModel arrivalAirport;
  @override
  final DateTime scheduledDeparture;
  @override
  final DateTime scheduledArrival;
  @override
  final DateTime? actualDeparture;
  @override
  final DateTime? actualArrival;
  @override
  final DelayReason? delayReason;
  @override
  final String? delayReasonDescription;
  @override
  final double distanceKm;
  @override
  final FlightJurisdiction jurisdiction;
  @override
  final double? compensationAmount;
  @override
  final String? aircraftType;
  @override
  final String? gate;
  @override
  final String? seat;

  @override
  String toString() {
    return 'FlightModel(flightNumber: $flightNumber, airline: $airline, departureAirport: $departureAirport, arrivalAirport: $arrivalAirport, scheduledDeparture: $scheduledDeparture, scheduledArrival: $scheduledArrival, actualDeparture: $actualDeparture, actualArrival: $actualArrival, delayReason: $delayReason, delayReasonDescription: $delayReasonDescription, distanceKm: $distanceKm, jurisdiction: $jurisdiction, compensationAmount: $compensationAmount, aircraftType: $aircraftType, gate: $gate, seat: $seat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlightModelImpl &&
            (identical(other.flightNumber, flightNumber) ||
                other.flightNumber == flightNumber) &&
            (identical(other.airline, airline) || other.airline == airline) &&
            (identical(other.departureAirport, departureAirport) ||
                other.departureAirport == departureAirport) &&
            (identical(other.arrivalAirport, arrivalAirport) ||
                other.arrivalAirport == arrivalAirport) &&
            (identical(other.scheduledDeparture, scheduledDeparture) ||
                other.scheduledDeparture == scheduledDeparture) &&
            (identical(other.scheduledArrival, scheduledArrival) ||
                other.scheduledArrival == scheduledArrival) &&
            (identical(other.actualDeparture, actualDeparture) ||
                other.actualDeparture == actualDeparture) &&
            (identical(other.actualArrival, actualArrival) ||
                other.actualArrival == actualArrival) &&
            (identical(other.delayReason, delayReason) ||
                other.delayReason == delayReason) &&
            (identical(other.delayReasonDescription, delayReasonDescription) ||
                other.delayReasonDescription == delayReasonDescription) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.jurisdiction, jurisdiction) ||
                other.jurisdiction == jurisdiction) &&
            (identical(other.compensationAmount, compensationAmount) ||
                other.compensationAmount == compensationAmount) &&
            (identical(other.aircraftType, aircraftType) ||
                other.aircraftType == aircraftType) &&
            (identical(other.gate, gate) || other.gate == gate) &&
            (identical(other.seat, seat) || other.seat == seat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    flightNumber,
    airline,
    departureAirport,
    arrivalAirport,
    scheduledDeparture,
    scheduledArrival,
    actualDeparture,
    actualArrival,
    delayReason,
    delayReasonDescription,
    distanceKm,
    jurisdiction,
    compensationAmount,
    aircraftType,
    gate,
    seat,
  );

  /// Create a copy of FlightModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlightModelImplCopyWith<_$FlightModelImpl> get copyWith =>
      __$$FlightModelImplCopyWithImpl<_$FlightModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FlightModelImplToJson(this);
  }
}

abstract class _FlightModel extends FlightModel {
  const factory _FlightModel({
    required final String flightNumber,
    required final String airline,
    required final AirportModel departureAirport,
    required final AirportModel arrivalAirport,
    required final DateTime scheduledDeparture,
    required final DateTime scheduledArrival,
    final DateTime? actualDeparture,
    final DateTime? actualArrival,
    final DelayReason? delayReason,
    final String? delayReasonDescription,
    required final double distanceKm,
    required final FlightJurisdiction jurisdiction,
    final double? compensationAmount,
    final String? aircraftType,
    final String? gate,
    final String? seat,
  }) = _$FlightModelImpl;
  const _FlightModel._() : super._();

  factory _FlightModel.fromJson(Map<String, dynamic> json) =
      _$FlightModelImpl.fromJson;

  @override
  String get flightNumber;
  @override
  String get airline;
  @override
  AirportModel get departureAirport;
  @override
  AirportModel get arrivalAirport;
  @override
  DateTime get scheduledDeparture;
  @override
  DateTime get scheduledArrival;
  @override
  DateTime? get actualDeparture;
  @override
  DateTime? get actualArrival;
  @override
  DelayReason? get delayReason;
  @override
  String? get delayReasonDescription;
  @override
  double get distanceKm;
  @override
  FlightJurisdiction get jurisdiction;
  @override
  double? get compensationAmount;
  @override
  String? get aircraftType;
  @override
  String? get gate;
  @override
  String? get seat;

  /// Create a copy of FlightModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlightModelImplCopyWith<_$FlightModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
