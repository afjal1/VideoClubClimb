import '../form_submission_state.dart';

class ForgotState {
  final String email;

  final FormSubmissionState formSubmissionState;

  ForgotState({
    this.email = '',

    this.formSubmissionState = const InitialFormState(),
  });

  bool get isValidEmail => email.contains('@') ? true : false;


  ForgotState copyWith({
    String? email,
    FormSubmissionState? formSubmissionState,
  }){
    return ForgotState(
      email: email ?? this.email,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
