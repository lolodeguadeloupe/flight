// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Airport {
  String get code => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Create a copy of Airport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AirportCopyWith<Airport> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AirportCopyWith<$Res> {
  factory $AirportCopyWith(Airport value, $Res Function(Airport) then) =
      _$AirportCopyWithImpl<$Res, Airport>;
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
class _$AirportCopyWithImpl<$Res, $Val extends Airport>
    implements $AirportCopyWith<$Res> {
  _$AirportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Airport
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
abstract class _$$AirportImplCopyWith<$Res> implements $AirportCopyWith<$Res> {
  factory _$$AirportImplCopyWith(
    _$AirportImpl value,
    $Res Function(_$AirportImpl) then,
  ) = __$$AirportImplCopyWithImpl<$Res>;
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
class __$$AirportImplCopyWithImpl<$Res>
    extends _$AirportCopyWithImpl<$Res, _$AirportImpl>
    implements _$$AirportImplCopyWith<$Res> {
  __$$AirportImplCopyWithImpl(
    _$AirportImpl _value,
    $Res Function(_$AirportImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Airport
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
      _$AirportImpl(
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

class _$AirportImpl implements _Airport {
  const _$AirportImpl({
    required this.code,
    required this.name,
    required this.city,
    required this.country,
    this.latitude,
    this.longitude,
  });

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
    return 'Airport(code: $code, name: $name, city: $city, country: $country, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AirportImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, code, name, city, country, latitude, longitude);

  /// Create a copy of Airport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AirportImplCopyWith<_$AirportImpl> get copyWith =>
      __$$AirportImplCopyWithImpl<_$AirportImpl>(this, _$identity);
}

abstract class _Airport implements Airport {
  const factory _Airport({
    required final String code,
    required final String name,
    required final String city,
    required final String country,
    final double? latitude,
    final double? longitude,
  }) = _$AirportImpl;

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

  /// Create a copy of Airport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AirportImplCopyWith<_$AirportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Flight {
  String get flightNumber => throw _privateConstructorUsedError;
  String get airline => throw _privateConstructorUsedError;
  Airport get departureAirport => throw _privateConstructorUsedError;
  Airport get arrivalAirport => throw _privateConstructorUsedError;
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

  /// Create a copy of Flight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FlightCopyWith<Flight> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FlightCopyWith<$Res> {
  factory $FlightCopyWith(Flight value, $Res Function(Flight) then) =
      _$FlightCopyWithImpl<$Res, Flight>;
  @useResult
  $Res call({
    String flightNumber,
    String airline,
    Airport departureAirport,
    Airport arrivalAirport,
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

  $AirportCopyWith<$Res> get departureAirport;
  $AirportCopyWith<$Res> get arrivalAirport;
}

/// @nodoc
class _$FlightCopyWithImpl<$Res, $Val extends Flight>
    implements $FlightCopyWith<$Res> {
  _$FlightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Flight
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
                      as Airport,
            arrivalAirport: null == arrivalAirport
                ? _value.arrivalAirport
                : arrivalAirport // ignore: cast_nullable_to_non_nullable
                      as Airport,
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

  /// Create a copy of Flight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AirportCopyWith<$Res> get departureAirport {
    return $AirportCopyWith<$Res>(_value.departureAirport, (value) {
      return _then(_value.copyWith(departureAirport: value) as $Val);
    });
  }

  /// Create a copy of Flight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AirportCopyWith<$Res> get arrivalAirport {
    return $AirportCopyWith<$Res>(_value.arrivalAirport, (value) {
      return _then(_value.copyWith(arrivalAirport: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FlightImplCopyWith<$Res> implements $FlightCopyWith<$Res> {
  factory _$$FlightImplCopyWith(
    _$FlightImpl value,
    $Res Function(_$FlightImpl) then,
  ) = __$$FlightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String flightNumber,
    String airline,
    Airport departureAirport,
    Airport arrivalAirport,
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
  $AirportCopyWith<$Res> get departureAirport;
  @override
  $AirportCopyWith<$Res> get arrivalAirport;
}

/// @nodoc
class __$$FlightImplCopyWithImpl<$Res>
    extends _$FlightCopyWithImpl<$Res, _$FlightImpl>
    implements _$$FlightImplCopyWith<$Res> {
  __$$FlightImplCopyWithImpl(
    _$FlightImpl _value,
    $Res Function(_$FlightImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Flight
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
      _$FlightImpl(
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
                  as Airport,
        arrivalAirport: null == arrivalAirport
            ? _value.arrivalAirport
            : arrivalAirport // ignore: cast_nullable_to_non_nullable
                  as Airport,
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

class _$FlightImpl extends _Flight {
  const _$FlightImpl({
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

  @override
  final String flightNumber;
  @override
  final String airline;
  @override
  final Airport departureAirport;
  @override
  final Airport arrivalAirport;
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
    return 'Flight(flightNumber: $flightNumber, airline: $airline, departureAirport: $departureAirport, arrivalAirport: $arrivalAirport, scheduledDeparture: $scheduledDeparture, scheduledArrival: $scheduledArrival, actualDeparture: $actualDeparture, actualArrival: $actualArrival, delayReason: $delayReason, delayReasonDescription: $delayReasonDescription, distanceKm: $distanceKm, jurisdiction: $jurisdiction, compensationAmount: $compensationAmount, aircraftType: $aircraftType, gate: $gate, seat: $seat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FlightImpl &&
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

  /// Create a copy of Flight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FlightImplCopyWith<_$FlightImpl> get copyWith =>
      __$$FlightImplCopyWithImpl<_$FlightImpl>(this, _$identity);
}

abstract class _Flight extends Flight {
  const factory _Flight({
    required final String flightNumber,
    required final String airline,
    required final Airport departureAirport,
    required final Airport arrivalAirport,
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
  }) = _$FlightImpl;
  const _Flight._() : super._();

  @override
  String get flightNumber;
  @override
  String get airline;
  @override
  Airport get departureAirport;
  @override
  Airport get arrivalAirport;
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

  /// Create a copy of Flight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FlightImplCopyWith<_$FlightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
