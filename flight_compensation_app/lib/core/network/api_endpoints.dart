class ApiEndpoints {
  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String refreshToken = '/auth/refresh';
  static const String logout = '/auth/logout';
  
  // Flight endpoints
  static const String searchFlight = '/flights/search';
  static const String flightDetails = '/flights/{id}';
  
  // Claim endpoints
  static const String claims = '/claims';
  static const String claimDetails = '/claims/{id}';
  static const String submitClaim = '/claims';
  static const String calculateCompensation = '/claims/calculate';
  
  // Document endpoints
  static const String uploadDocument = '/documents/upload';
  static const String documentDetails = '/documents/{id}';
  
  // User endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile';
  
  // Utility methods
  static String getClaimDetails(String claimId) {
    return claimDetails.replaceAll('{id}', claimId);
  }
  
  static String getFlightDetails(String flightId) {
    return flightDetails.replaceAll('{id}', flightId);
  }
  
  static String getDocumentDetails(String documentId) {
    return documentDetails.replaceAll('{id}', documentId);
  }
}