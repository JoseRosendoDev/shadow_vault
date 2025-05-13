import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class LocalAuthService {
  final _auth = LocalAuthentication();

  Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  Future<bool> authenticate() async {
    try {
      final isAvailable = await _auth.canCheckBiometrics;

      if (!isAvailable) return false;

      return await _auth.authenticate(
        localizedReason: 'Scan to Authenticate',
        options: const AuthenticationOptions(
            biometricOnly: true, useErrorDialogs: true),
      );
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        throw ('device does not have hardware support for biometrics.');
      }

      if (e.code == auth_error.notEnrolled) {
        throw ('No ha registrado ningún dato biométrico en el dispositivo.');
      }
      if (e.code == auth_error.passcodeNotSet) {
        throw ('has not yet configured a passcode  PIN/pattern/password on the device.');
      }
      return false;
    }
  }
}
