abstract class SignupEvent{}

class SignupUsernameChangedEvent extends SignupEvent{
  final String email;

  SignupUsernameChangedEvent({required this.email});
}

class SignupPasswordChangedEvent extends SignupEvent{
  final String password;

  SignupPasswordChangedEvent({required this.password});
}

class SignupButtonClicked extends SignupEvent{}

