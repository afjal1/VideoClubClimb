abstract class ConfirmationForgotEvent{}

class ConfirmationCodeChangedEvent extends ConfirmationForgotEvent{
  final String code;

  ConfirmationCodeChangedEvent({required this.code});
}


class NewPassChangedEvent extends ConfirmationForgotEvent{
  final String newpass;

  NewPassChangedEvent({required this.newpass});
}


class ConfirmationButtonClicked extends ConfirmationForgotEvent{}

