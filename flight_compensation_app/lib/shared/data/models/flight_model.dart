import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/flight.dart';

part 'flight_model.freezed.dart';
part 'flight_model.g.dart';

@freezed
class AirportModel with _$AirportModel {
  const factory AirportModel({
    required String code,
    required String name,
    required String city,
    required String country,
    double? latitude,
    double? longitude,
  }) = _AirportModel;

  const AirportModel._();

  factory AirportModel.fromJson(Map<String, dynamic> json) =>
      _$AirportModelFromJson(json);

  factory AirportModel.fromEntity(Airport airport) => AirportModel(
        code: airport.code,
        name: airport.name,
        city: airport.city,
        country: airport.country,
        latitude: airport.latitude,
        longitude: airport.longitude,
      );

  Airport toEntity() => Airport(
        code: code,
        name: name,
        city: city,
        country: country,
        latitude: latitude,
        longitude: longitude,
      );
}

@freezed
class FlightModel with _$FlightModel {
  const factory FlightModel({
    required String flightNumber,
    required String airline,
    required AirportModel departureAirport,
    required AirportModel arrivalAirport,
    required DateTime scheduledDeparture,
    required DateTime scheduledArrival,
    DateTime? actualDeparture,
    DateTime? actualArrival,
    DelayReason? delayReason,
    String? delayReasonDescription,
    required double distanceKm,
    required FlightJurisdiction jurisdiction,
    double? compensationAmount,
    String? aircraftType,
    String? gate,
    String? seat,
  }) = _FlightModel;

  const FlightModel._();

  factory FlightModel.fromJson(Map<String, dynamic> json) =>
      _$FlightModelFromJson(json);

  factory FlightModel.fromEntity(Flight flight) => FlightModel(
        flightNumber: flight.flightNumber,
        airline: flight.airline,
        departureAirport: AirportModel.fromEntity(flight.departureAirport),
        arrivalAirport: AirportModel.fromEntity(flight.arrivalAirport),
        scheduledDeparture: flight.scheduledDeparture,
        scheduledArrival: flight.scheduledArrival,
        actualDeparture: flight.actualDeparture,
        actualArrival: flight.actualArrival,
        delayReason: flight.delayReason,
        delayReasonDescription: flight.delayReasonDescription,
        distanceKm: flight.distanceKm,
        jurisdiction: flight.jurisdiction,
        compensationAmount: flight.compensationAmount,
        aircraftType: flight.aircraftType,
        gate: flight.gate,
        seat: flight.seat,
      );

  Flight toEntity() => Flight(
        flightNumber: flightNumber,
        airline: airline,
        departureAirport: departureAirport.toEntity(),
        arrivalAirport: arrivalAirport.toEntity(),
        scheduledDeparture: scheduledDeparture,
        scheduledArrival: scheduledArrival,
        actualDeparture: actualDeparture,
        actualArrival: actualArrival,
        delayReason: delayReason,
        delayReasonDescription: delayReasonDescription,
        distanceKm: distanceKm,
        jurisdiction: jurisdiction,
        compensationAmount: compensationAmount,
        aircraftType: aircraftType,
        gate: gate,
        seat: seat,
      );
}