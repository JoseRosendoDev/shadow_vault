import 'package:auth_local_repository/auth_local_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_local_event.dart';
part 'auth_local_state.dart';

class AuthLocalBloc extends Bloc<AuthLocalEvent, AuthLocalState> {
  final AuthRepository _authRepository;

  AuthLocalBloc(this._authRepository) : super(AuthLocalInitial()) {
    on<AuthStartAuthentication>((event, emit) async {
      if (state is AuthLoading) {
      return;
    }
      emit(AuthLoading());
      try {
        bool isAuthenticated =
            await _authRepository.authenticateWithBiometrics();
        if (isAuthenticated) {
          emit(Authenticated());
        } else {
          emit(Unthenticated());
        }
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
  }
}
