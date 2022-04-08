abstract class ConfirmationEvent{}

class ConfirmationCodeChangedEvent extends ConfirmationEvent{
  final String code;

  ConfirmationCodeChangedEvent({required this.code});
}

class ConfirmationButtonClicked extends ConfirmationEvent{}

