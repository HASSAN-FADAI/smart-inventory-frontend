import '../../../../core/network/api_service.dart';
import '../models/user_model.dart';

class AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSource(this.apiService);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post('/auth/login', {
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response);
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiService.post('/auth/register', {
      'name': name,
      'email': email,
      'password': password,
    });
    return UserModel.fromJson(response);
  }

  Future<void> logout() async {
    await apiService.post('/auth/logout', {});
  }
}
