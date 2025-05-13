part of 'password_bloc.dart';
abstract class PasswordEvent extends Equatable {
  const PasswordEvent();
}

class Initial extends PasswordEvent {
  @override
  List<Object?> get props => [];
}

class SetPassword extends PasswordEvent {
  final String password;
  const SetPassword(this.password);

  @override
  List<Object?> get props => [password];
}

class GeneratePassword extends PasswordEvent {
  final double passwordLength;
  final bool isWithLetters;
  final bool isWithUppercase;
  final bool isWithNumbers;
  final bool isWithSpecial;

  const GeneratePassword({
    required this.passwordLength,
    this.isWithLetters = false,
    this.isWithUppercase = false,
    this.isWithNumbers = false,
    this.isWithSpecial = false,
  });

  @override
  List<Object?> get props => [
        passwordLength,
        isWithLetters,
        isWithUppercase,
        isWithNumbers,
        isWithSpecial,
      ];
}

