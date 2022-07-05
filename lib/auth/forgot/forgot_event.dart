abstract class ForgotEvent{}

class ForgotUsernameChangedEvent extends ForgotEvent{
  final String email;

  ForgotUsernameChangedEvent({required this.email});
}


class ForgotButtonClicked extends ForgotEvent{}

