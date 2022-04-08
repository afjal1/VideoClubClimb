abstract class LoginEvent{}

class LoginUsernameChangedEvent extends LoginEvent{
  final String email;

  LoginUsernameChangedEvent({required this.email});
}

class LoginPasswordChangedEvent extends LoginEvent{
  final String password;

  LoginPasswordChangedEvent({required this.password});
}

class LoginButtonClicked extends LoginEvent{}

