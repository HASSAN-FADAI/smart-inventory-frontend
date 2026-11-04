class UserEntity {
  final String id;
  final String email;
  final String role;
  final String accessToken;
  final String refreshToken;

  const UserEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
  });
}
