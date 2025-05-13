import 'package:random_password_generator/random_password_generator.dart';

class PasswordService {
  final RandomPasswordGenerator _passwordGenerator = RandomPasswordGenerator();

  /// Generates a random password with the specified parameters.
  ///
  /// [length] - Length of the password
  /// [includeUpperCase]  - Include uppercase letters.
  /// [includeNumbers] - Include numbers.
  /// [includeSpecialChars] - Include special characters.
  Future<String> generatePassword({
    double length = 26,
    bool includeUpperCase = false,
    bool includeNumbers = false,
    bool includeSpecialChars = false,
    bool letters = false,
  }) async {
    return _passwordGenerator.randomPassword(
      letters: letters,
      uppercase: includeUpperCase,
      numbers: includeNumbers,
      specialChar: includeSpecialChars,
      passwordLength: length,
    );
  }

  /// Validates if a password meets the security criteria.
  ///
  ///  Returns a value between 0 and 100, where 100 is the highest security.
  Future<double> validatePassword(String password) async {
    return _passwordGenerator.checkPassword(password: password);
  }
}
