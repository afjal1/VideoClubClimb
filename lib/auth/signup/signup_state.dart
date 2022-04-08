import '../form_submission_state.dart';

class SignupState {
  final String email;
  final String password;
  final FormSubmissionState formSubmissionState;

  SignupState({
    this.email = '',
    this.password = '',
    this.formSubmissionState = const InitialFormState(),
  });

  bool get isValidEmail => email.contains('@') ? true : false;
  bool get isValidPassword => password.length >= 8 ? true : false;

  SignupState copyWith({
    String? email,
    String? password,
    FormSubmissionState? formSubmissionState,
  }){

  return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
      );
  }
}
