import '../form_submission_state.dart';

class ConfirmationForgotState {
  final String newpass;
  final String code;
  final FormSubmissionState formSubmissionState;

  bool get isValidCode => code.length == 6 ? true : false;

  bool get isValidPass => newpass.length == 8 ? true : false;


  int leng(){
    return code.length;
  }

  int lengPass(){
    return newpass.length;
  }

  ConfirmationForgotState({
    this.newpass = '',
    this.code = '',
    this.formSubmissionState = const InitialFormState(),
  });

  ConfirmationForgotState copyWith({
    String? newpass,
    String? code,
    FormSubmissionState? formSubmissionState,
  }){
    return ConfirmationForgotState(
      newpass: newpass ?? this.newpass,
      code: code ?? this.code,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
