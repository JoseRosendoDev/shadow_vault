import 'package:password_service/password_service.dart';

class PasswordRepository {
  final PasswordService _passwordService;
  PasswordRepository({PasswordService? passwordService})
      : _passwordService = passwordService ?? PasswordService();

  /// Generates a random password with the specified parameters.
  Future<String> getRandomPassword({
    double length = 26,
    bool includeUpperCase = false,
    bool includeNumbers = false,
    bool includeSpecialChars = false,
    bool includeLetters = false,
  }) async {
    return await _passwordService.generatePassword(
        length: length,
        includeUpperCase: includeUpperCase,
        includeNumbers: includeNumbers,
        includeSpecialChars: includeSpecialChars,
        letters: includeLetters);
  }

  /// Checks the strength of a given password.
  Future<double> checkPasswordStrength(String password) async {
    return await _passwordService.validatePassword(password);
  }
}
