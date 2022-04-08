abstract class SessionState{}

class UnknownSessionState extends SessionState{}

class UnauthenticatedSessionState extends SessionState {}

class AuthenticatedSessionState extends SessionState {
  final dynamic user;

  AuthenticatedSessionState({required this.user});
}