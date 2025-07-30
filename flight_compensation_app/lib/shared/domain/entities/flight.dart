import 'package:freezed_annotation/freezed_annotation.dart';

part 'flight.freezed.dart';

enum FlightJurisdiction {
  eu,
  brazil,
  usa,
  canada,
  other,
}

enum DelayReason {
  technical,
  weather,
  strike,
  airTraffic,
  extraordinaryCircumstances,
  other,
}

@freezed
class Airport with _$Airport {
  const factory Airport({
    required String code,
    required String name,
    required String city,
    required String country,
    double? latitude,
    double? longitude,
  }) = _Airport;
}

@freezed
class Flight with _$Flight {
  const factory Flight({
    required String flightNumber,
    required String airline,
    required Airport departureAirport,
    required Airport arrivalAirport,
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
  }) = _Flight;

  const Flight._();

  Duration get scheduledFlightDuration => 
      scheduledArrival.difference(scheduledDeparture);

  Duration? get actualDelayDuration {
    if (actualDeparture == null) return null;
    return actualDeparture!.difference(scheduledDeparture);
  }

  Duration? get arrivalDelayDuration {
    if (actualArrival == null) return null;
    return actualArrival!.difference(scheduledArrival);
  }

  bool get isDelayed => 
      actualDelayDuration != null && 
      actualDelayDuration!.inMinutes > 15;

  bool get isEligibleForCompensation {
    final delay = arrivalDelayDuration;
    if (delay == null) return false;
    
    switch (jurisdiction) {
      case FlightJurisdiction.eu:
        // EC261 rules
        if (distanceKm <= 1500) {
          return delay.inHours >= 3;
        } else if (distanceKm <= 3500) {
          return delay.inHours >= 3;
        } else {
          return delay.inHours >= 4;
        }
      case FlightJurisdiction.brazil:
        // ANAC400 rules
        return delay.inHours >= 4;
      case FlightJurisdiction.usa:
      case FlightJurisdiction.canada:
      case FlightJurisdiction.other:
        return false;
    }
  }

  double get calculatedCompensationAmount {
    if (!isEligibleForCompensation) return 0.0;
    
    switch (jurisdiction) {
      case FlightJurisdiction.eu:
        if (distanceKm <= 1500) {
          return 250.0;
        } else if (distanceKm <= 3500) {
          return 400.0;
        } else {
          return 600.0;
        }
      case FlightJurisdiction.brazil:
        // ANAC400 compensation varies
        return 500.0;
      case FlightJurisdiction.usa:
      case FlightJurisdiction.canada:
      case FlightJurisdiction.other:
        return 0.0;
    }
  }
}