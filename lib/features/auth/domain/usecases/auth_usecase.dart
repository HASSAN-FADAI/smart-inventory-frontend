import '../entities/user_entity.dart';
import '../repos/auth_repo.dart';

class AuthUseCase {
  final AuthRepo authRepo;

  const AuthUseCase(this.authRepo);

  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    return await authRepo.login(email: email, password: password);
  }

  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await authRepo.register(
      name: name,
      email: email,
      password: password,
    );
  }

  Future<void> logout() async {
    return await authRepo.logout();
  }
}
