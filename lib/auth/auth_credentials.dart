

class AuthCredentials{
  final String email;
  final String? password;
  String? userID;

  AuthCredentials({
    required this.email,
    this.password,
    this.userID,
  });
}