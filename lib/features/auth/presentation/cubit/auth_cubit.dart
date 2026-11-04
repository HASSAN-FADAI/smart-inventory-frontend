import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/core/errors/api_error.dart';
import 'package:inventory_managment/features/auth/domain/usecases/auth_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase loginUseCase, registerUseCase;

  AuthCubit({required this.loginUseCase, required this.registerUseCase})
    : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.login(email: email, password: password);
      emit(AuthSuccess(user, isLogin: true));
    } on ApiError catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await registerUseCase.register(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthSuccess(user, isLogin: false));
    } on ApiError catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
