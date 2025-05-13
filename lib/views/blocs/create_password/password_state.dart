part of 'password_bloc.dart';

abstract class PasswordState extends Equatable {
  const PasswordState();
}

final class PasswordInitial extends PasswordState {
  const PasswordInitial();

  @override
  List<Object?> get props => [];
}

final class PasswordLoading extends PasswordState {
  const PasswordLoading();

  @override
  List<Object?> get props => [];
}

final class PasswordGenerated extends PasswordState {
  final String password;
  
  const PasswordGenerated(this.password);

  @override
  List<Object?> get props => [password];
}

class PasswordFailed extends PasswordState {
  final String errorMessage;

  const PasswordFailed(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
