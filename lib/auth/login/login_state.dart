import '../form_submission_state.dart';

class LoginState {
  final String email;
  final String password;
  final FormSubmissionState formSubmissionState;

  LoginState({
    this.email = '',
    this.password = '',
    this.formSubmissionState = const InitialFormState(),
  });

  bool get isValidEmail => email.contains('@') ? true : false;
  bool get isValidPassword => password.length >= 8 ? true : false;

  LoginState copyWith({
    String? email,
    String? password,
    FormSubmissionState? formSubmissionState,
  }){
  return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
      );
  }
}
