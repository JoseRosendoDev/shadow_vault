import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shadow_vault/data/password.dart';
import 'package:shadow_vault/objectbox.g.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomePasswordBloc extends Bloc<HomeEvent, HomeState> {
  final Box<Password> boxtask;
  HomePasswordBloc(this.boxtask) : super(HomeInitial()) {
    on<GetPasswords>((event, emit) async {
      emit(HomeLoading());
      try {
        final passwords = await boxtask.getAllAsync();
        emit(HomeLoaded(passwords));
      } catch (e) {
        emit(HomeFailed(e.toString()));
      }
    });

    on<GetPassword>((event, emit) {
      final password = boxtask.get(event.id);
      emit(PasswordLoaded(password));
    });

    on<ButtonFilter>((event, emit) async {
      emit(HomeLoading());
      QueryBuilder<Password> queryBuilder = boxtask.query();

      if (event.sortBy == SortOption.creationDate) {
        queryBuilder = queryBuilder.order(
          Password_.created,
        );
      } else if (event.sortBy == SortOption.alphabetical) {
        queryBuilder = queryBuilder.order(
          Password_.title,
        );
      }

      final query = queryBuilder.build();

      final passwords = await query.findAsync();

      emit(HomeLoaded(passwords));
    });

    on<SavePassword>((event, emit) async {
      emit(HomeLoading());

      try {
        await boxtask.putAsync(event.password);
        add(GetPasswords());
      } catch (e) {
        emit(HomeFailed(e.toString()));
      }
    });

    on<DeletePassword>((event, emit) {
      try {
        boxtask.remove(event.id);
        add(GetPasswords());
      } catch (e) {
        emit(HomeFailed(e.toString()));
      }
    });
  }
}
