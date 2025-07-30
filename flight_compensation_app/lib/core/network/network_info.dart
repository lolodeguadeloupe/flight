import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<ConnectionType> get connectionType;
  Stream<bool> get onConnectivityChanged;
}

enum ConnectionType {
  wifi,
  mobile,
  ethernet,
  none,
  unknown,
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<ConnectionType> get connectionType async {
    // Implémentation simplifiée
    // En production, utiliser connectivity_plus package
    final connected = await isConnected;
    return connected ? ConnectionType.unknown : ConnectionType.none;
  }

  @override
  Stream<bool> get onConnectivityChanged {
    // Implémentation simplifiée
    // En production, utiliser connectivity_plus package
    return Stream.periodic(
      const Duration(seconds: 10),
      (count) => true,
    ).asyncMap((_) => isConnected);
  }
}