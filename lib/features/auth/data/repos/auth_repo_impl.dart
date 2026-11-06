import 'package:inventory_managment/core/utils/pref_helper.dart';
import 'package:inventory_managment/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:inventory_managment/features/auth/domain/entities/user_entity.dart';
import 'package:inventory_managment/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.login(email: email, password: password);

    await PrefHelper.saveToken(user.accessToken);
    await PrefHelper.saveUserData(
      id: user.id,
      email: user.email,
      role: user.role,
    );

    return user;
  }

  @override
  Future<UserEntity> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final user = await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );

    await PrefHelper.saveToken(user.accessToken);
    await PrefHelper.saveUserData(
      id: user.id,
      email: user.email,
      role: user.role,
    );

    return user;
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } finally {
      await PrefHelper.clearAll();
    }
  }
}
