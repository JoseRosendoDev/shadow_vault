part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {}

final class HomeInitial extends HomeState {
 @override
  List<Object?> get props => [];
}

final class HomeLoading extends HomeState {
 @override
  List<Object?> get props => [];
}

final class PasswordHomeLoading extends HomeState {
 @override
  List<Object?> get props => [];
}

final class PasswordLoaded extends HomeState {
  PasswordLoaded(this.passwords);
  final Password? passwords;
  
 @override
  List<Object?> get props => [passwords];
}

final class HomeLoaded extends HomeState {
  HomeLoaded(this.passwords);
  final List<Password> passwords;
  
  @override
  List<Object?> get props => [passwords];
}

final class HomeFailed extends HomeState {
  final String errorMessage;
  HomeFailed(this.errorMessage);
  
 @override
  List<Object?> get props => [errorMessage];
}
