import '../form_submission_state.dart';

class ConfirmationState {
  final String code;
  final FormSubmissionState formSubmissionState;

  bool get isValidCode => code.length == 6 ? true : false;

  int leng(){
    return code.length;
  }

  ConfirmationState({
    this.code = '',
    this.formSubmissionState = const InitialFormState(),
  });

  ConfirmationState copyWith({
    String? code,
    FormSubmissionState? formSubmissionState,
  }){
    return ConfirmationState(
      code: code ?? this.code,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
