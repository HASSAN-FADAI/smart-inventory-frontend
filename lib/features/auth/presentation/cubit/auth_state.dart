import 'package:inventory_managment/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;
  final bool isLogin;
  AuthSuccess(this.user, {required this.isLogin});
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

class AuthLocked extends AuthState {
  final int remainingSeconds;
  AuthLocked(this.remainingSeconds);
}
