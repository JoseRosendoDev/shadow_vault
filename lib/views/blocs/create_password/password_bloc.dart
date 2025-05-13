import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:password_repository/password_repository.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final PasswordRepository _passwordRepository;
  PasswordBloc(this._passwordRepository) : super(PasswordInitial()) {
    on<GeneratePassword>((event, emit) async {
      emit(PasswordLoading());

      try {
        final password = await _passwordRepository.getRandomPassword(
            includeNumbers: event.isWithNumbers,
            includeSpecialChars: event.isWithSpecial,
            includeUpperCase: event.isWithUppercase,
            length: event.passwordLength,
            includeLetters: event.isWithLetters);

        emit(PasswordGenerated(password));
      } catch (e) {
        emit(PasswordFailed(e.toString()));
      }
    });
    on<Initial>((event, emit) async {});

    on<SetPassword>((event, emit) async {
      emit(PasswordGenerated(event.password));
    });
  }
}
