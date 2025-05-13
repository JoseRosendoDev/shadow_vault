import 'package:auth_local_service/auth_local_service.dart';

class AuthRepository {
  final LocalAuthService _localAuthService;
  AuthRepository({LocalAuthService? localAuthService})
      : _localAuthService = localAuthService ?? LocalAuthService();

  // Check if the device supports biometric authentication
  Future<bool> canCheckBiometrics() async {
    return await _localAuthService.hasBiometrics();
  }

  // Get the available biometric types (fingerprint, facial recognition, etc.)
  Future<List<String>> getAvailableBiometrics() async {
    final biometrics = await _localAuthService.getBiometrics();
    return biometrics.map((biometric) => biometric.toString()).toList();
  }

  // Authenticate using biometrics
  Future<bool> authenticateWithBiometrics() async {
    return await _localAuthService.authenticate();
  }
}
