part of 'auth_local_bloc.dart';

class AuthLocalState extends Equatable {
  @override
  List<Object?> get props => [];

}

class AuthLocalInitial extends AuthLocalState {}

class AuthLoading extends AuthLocalState {}

class Authenticated extends AuthLocalState {}
class Unthenticated extends AuthLocalState {}

class AuthFailed extends AuthLocalState {
  final String message;

   AuthFailed(this.message);

  @override
  List<Object?> get props => [message];
}
