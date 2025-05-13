part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {}

enum SortOption { creationDate, alphabetical }

class GetPasswords extends HomeEvent {
  @override
  List<Object?> get props => [];
}

class DeletePassword extends HomeEvent {
  DeletePassword(this.id);
  final int id;
  
   @override
  List<Object?> get props => [id];
}

class ButtonFilter extends HomeEvent {
  final SortOption sortBy; // Opción de ordenamiento

  ButtonFilter({required this.sortBy});
  
  @override
  List<Object?> get props =>[ sortBy];
}

class GetPassword extends HomeEvent {
  GetPassword(this.id);
  final int id;
  
  @override
  
  List<Object?> get props =>[id];
}

class SavePassword extends HomeEvent {
  final Password password;
  SavePassword(this.password);
  
  @override
  List<Object?> get props => [password];
}
