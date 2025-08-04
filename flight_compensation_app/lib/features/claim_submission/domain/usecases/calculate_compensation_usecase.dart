import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class CalculateCompensationUseCase {
  Either<Failure, double> call({
    required String departureAirport,
    required String arrivalAirport,
    required double delayDuration,
    String? flightNumber,
  }) {
    try {
      // Validation des paramètres
      if (delayDuration < 3) {
        return const Left(ValidationFailure('Le retard doit être d\'au moins 3 heures'));
      }
      
      if (departureAirport.length != 3 || arrivalAirport.length != 3) {
        return const Left(ValidationFailure('Codes aéroports invalides'));
      }
      
      // Calcul de la distance approximative pour déterminer le type de vol
      final distance = _calculateDistance(departureAirport, arrivalAirport);
      
      // Application des règles EC261 (European Regulation)
      double compensation = 0.0;
      
      if (distance <= 1500) {
        // Vol court-courrier (≤ 1500 km)
        if (delayDuration >= 3) {
          compensation = 250.0;
        }
      } else if (distance <= 3500) {
        // Vol moyen-courrier (1500-3500 km)
        if (delayDuration >= 3) {
          compensation = 400.0;
        }
      } else {
        // Vol long-courrier (> 3500 km)
        if (delayDuration >= 4) {
          compensation = 600.0;
        } else if (delayDuration >= 3) {
          compensation = 300.0; // Compensation réduite pour 3-4h sur long-courrier
        }
      }
      
      // Vérification de l'éligibilité pour certains aéroports européens
      if (!_isEuropeanAirport(departureAirport) && !_isEuropeanAirport(arrivalAirport)) {
        // Si ni le départ ni l'arrivée ne sont en Europe, 
        // d'autres réglementations peuvent s'appliquer
        compensation = _calculateNonEuropeanCompensation(
          departureAirport, 
          arrivalAirport, 
          delayDuration,
        );
      }
      
      return Right(compensation);
      
    } catch (e) {
      return Left(ServerFailure('Erreur lors du calcul de l\'indemnisation'));
    }
  }
  
  int _calculateDistance(String departureAirport, String arrivalAirport) {
    // Distances approximatives basées sur les codes IATA les plus courants
    // En production, ceci devrait utiliser une API ou une base de données géographique
    final distances = <String, Map<String, int>>{
      'CDG': {
        'LHR': 350,
        'JFK': 5840,
        'FCO': 1110,
        'MAD': 1050,
        'DXB': 5260,
        'NRT': 9720,
      },
      'LHR': {
        'CDG': 350,
        'JFK': 5550,
        'FCO': 1435,
        'MAD': 1260,
        'DXB': 5500,
      },
      'JFK': {
        'CDG': 5840,
        'LHR': 5550,
        'LAX': 3980,
        'MIA': 1750,
      },
      // Ajoutez d'autres combinaisons selon les besoins
    };
    
    final distanceMap = distances[departureAirport];
    if (distanceMap != null && distanceMap.containsKey(arrivalAirport)) {
      return distanceMap[arrivalAirport]!;
    }
    
    // Distance par défaut si non trouvée (vol moyen-courrier)
    return 2000;
  }
  
  bool _isEuropeanAirport(String airportCode) {
    // Liste des codes IATA des principaux aéroports européens
    const europeanAirports = {
      'CDG', 'LHR', 'FRA', 'AMS', 'MAD', 'FCO', 'MUC', 'ZUR', 'VIE', 'CPH',
      'ARN', 'OSL', 'HEL', 'BRU', 'LIS', 'ATH', 'WAW', 'PRG', 'BUD', 'OTP',
      'SOF', 'LJU', 'ZAG', 'SKG', 'TLV', 'IST', 'SAW', 'ESB', 'ADB', 'AYT',
      'ORY', 'NCE', 'LYS', 'TLS', 'MRS', 'NTE', 'BOD', 'LIL', 'STR', 'MPL',
      'DUS', 'HAM', 'STR', 'CGN', 'LEJ', 'NUE', 'HAJ', 'BRE', 'DRS', 'ERF',
      'BCN', 'PMI', 'AGP', 'VLC', 'BIO', 'LPA', 'TFS', 'ACE', 'SDR', 'OVD',
      'MXP', 'LIN', 'BGY', 'VCE', 'BLQ', 'NAP', 'CTA', 'PMO', 'CAG', 'BRI',
      'LGW', 'STN', 'LTN', 'MAN', 'BHX', 'EDI', 'GLA', 'NCL', 'LBA', 'BFS',
    };
    
    return europeanAirports.contains(airportCode);
  }
  
  double _calculateNonEuropeanCompensation(
    String departureAirport, 
    String arrivalAirport, 
    double delayDuration,
  ) {
    // Implémentation simplifiée pour les vols non-européens
    // En réalité, cela dépendrait des réglementations locales
    
    // Exemple : Réglementation brésilienne ANAC
    if (_isBrazilianAirport(departureAirport) || _isBrazilianAirport(arrivalAirport)) {
      if (delayDuration >= 4) {
        return 300.0; // Valeur approximative en euros
      } else if (delayDuration >= 3) {
        return 150.0;
      }
    }
    
    // Exemple : Réglementation américaine (compensation limitée)
    if (_isUSAirport(departureAirport) || _isUSAirport(arrivalAirport)) {
      // Les USA ont des règles de compensation très limitées
      return 0.0;
    }
    
    // Compensation par défaut basée sur la distance
    final distance = _calculateDistance(departureAirport, arrivalAirport);
    if (distance > 3500 && delayDuration >= 4) {
      return 400.0;
    } else if (distance > 1500 && delayDuration >= 3) {
      return 250.0;
    } else if (delayDuration >= 3) {
      return 150.0;
    }
    
    return 0.0;
  }
  
  bool _isBrazilianAirport(String airportCode) {
    const brazilianAirports = {
      'GRU', 'CGH', 'BSB', 'GIG', 'SDU', 'CNF', 'REC', 'SSA', 'FOR', 'MAO',
      'CWB', 'POA', 'BEL', 'CGB', 'VCP', 'FLN', 'NAT', 'MCZ', 'AJU', 'THE',
    };
    return brazilianAirports.contains(airportCode);
  }
  
  bool _isUSAirport(String airportCode) {
    const usAirports = {
      'JFK', 'LAX', 'ORD', 'MIA', 'DFW', 'SFO', 'LAS', 'PHX', 'IAH', 'DEN',
      'ATL', 'BOS', 'SEA', 'MSP', 'DTW', 'PHL', 'LGA', 'BWI', 'DCA', 'IAD',
    };
    return usAirports.contains(airportCode);
  }
}