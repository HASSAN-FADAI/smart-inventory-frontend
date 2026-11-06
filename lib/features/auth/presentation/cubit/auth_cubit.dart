import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_managment/core/errors/api_error.dart';
import 'package:inventory_managment/features/auth/domain/usecases/auth_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUseCase loginUseCase, registerUseCase, logoutUseCase;

  Timer? _cooldownTimer;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial());

  void _startCooldown() {
    int seconds = 15;
    emit(AuthLocked(seconds));

    _cooldownTimer?.cancel();
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      seconds--;
      if (seconds > 0) {
        emit(AuthLocked(seconds));
      } else {
        timer.cancel();
        emit(AuthInitial());
      }
    });
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.login(email: email, password: password);
      emit(AuthSuccess(user, isLogin: true));
    } on ApiError catch (e) {
      if (e.statusCode == 429 || e.message.contains('طلبات كثيرة')) {
        _startCooldown();
      } else {
        emit(AuthError(e.message));
      }
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
      if (e.statusCode == 429 || e.message.contains('طلبات كثيرة')) {
        _startCooldown();
      } else {
        emit(AuthError(e.message));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _cooldownTimer?.cancel();
    return super.close();
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUseCase.logout();
      emit(AuthLogoutSuccess());
    } on ApiError catch (e) {
      emit(AuthError(e.message));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
