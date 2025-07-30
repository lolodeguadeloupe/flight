// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flight_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AirportModelImpl _$$AirportModelImplFromJson(Map<String, dynamic> json) =>
    _$AirportModelImpl(
      code: json['code'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$AirportModelImplToJson(_$AirportModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'city': instance.city,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$FlightModelImpl _$$FlightModelImplFromJson(
  Map<String, dynamic> json,
) => _$FlightModelImpl(
  flightNumber: json['flightNumber'] as String,
  airline: json['airline'] as String,
  departureAirport: AirportModel.fromJson(
    json['departureAirport'] as Map<String, dynamic>,
  ),
  arrivalAirport: AirportModel.fromJson(
    json['arrivalAirport'] as Map<String, dynamic>,
  ),
  scheduledDeparture: DateTime.parse(json['scheduledDeparture'] as String),
  scheduledArrival: DateTime.parse(json['scheduledArrival'] as String),
  actualDeparture: json['actualDeparture'] == null
      ? null
      : DateTime.parse(json['actualDeparture'] as String),
  actualArrival: json['actualArrival'] == null
      ? null
      : DateTime.parse(json['actualArrival'] as String),
  delayReason: $enumDecodeNullable(_$DelayReasonEnumMap, json['delayReason']),
  delayReasonDescription: json['delayReasonDescription'] as String?,
  distanceKm: (json['distanceKm'] as num).toDouble(),
  jurisdiction: $enumDecode(_$FlightJurisdictionEnumMap, json['jurisdiction']),
  compensationAmount: (json['compensationAmount'] as num?)?.toDouble(),
  aircraftType: json['aircraftType'] as String?,
  gate: json['gate'] as String?,
  seat: json['seat'] as String?,
);

Map<String, dynamic> _$$FlightModelImplToJson(_$FlightModelImpl instance) =>
    <String, dynamic>{
      'flightNumber': instance.flightNumber,
      'airline': instance.airline,
      'departureAirport': instance.departureAirport,
      'arrivalAirport': instance.arrivalAirport,
      'scheduledDeparture': instance.scheduledDeparture.toIso8601String(),
      'scheduledArrival': instance.scheduledArrival.toIso8601String(),
      'actualDeparture': instance.actualDeparture?.toIso8601String(),
      'actualArrival': instance.actualArrival?.toIso8601String(),
      'delayReason': _$DelayReasonEnumMap[instance.delayReason],
      'delayReasonDescription': instance.delayReasonDescription,
      'distanceKm': instance.distanceKm,
      'jurisdiction': _$FlightJurisdictionEnumMap[instance.jurisdiction]!,
      'compensationAmount': instance.compensationAmount,
      'aircraftType': instance.aircraftType,
      'gate': instance.gate,
      'seat': instance.seat,
    };

const _$DelayReasonEnumMap = {
  DelayReason.technical: 'technical',
  DelayReason.weather: 'weather',
  DelayReason.strike: 'strike',
  DelayReason.airTraffic: 'airTraffic',
  DelayReason.extraordinaryCircumstances: 'extraordinaryCircumstances',
  DelayReason.other: 'other',
};

const _$FlightJurisdictionEnumMap = {
  FlightJurisdiction.eu: 'eu',
  FlightJurisdiction.brazil: 'brazil',
  FlightJurisdiction.usa: 'usa',
  FlightJurisdiction.canada: 'canada',
  FlightJurisdiction.other: 'other',
};
