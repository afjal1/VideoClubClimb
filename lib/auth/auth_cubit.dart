import 'package:flutter_bloc/flutter_bloc.dart';

import '../session_cubit.dart';
import 'auth_credentials.dart';

enum AuthState { login, signup, confirmSignup, forgot, confirmForgot }

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  SessionCubit sessionCubit;
  AuthCredentials? authCredentials;

  void showLogin() => emit(AuthState.login);
  void showSignup() => emit(AuthState.signup);
  void showConfirmation({
    String? email,
    String? password,
  }) {
    authCredentials = AuthCredentials(
      email: email!,
      password: password,
    );
    emit(AuthState.confirmSignup);
  }

  showSession(AuthCredentials authCredentials) =>
      sessionCubit.showSession(authCredentials);

  void showForgot() => emit(AuthState.forgot);
  void showConfirmationForgot({
    String? email,
    String? password,
  }) {
    authCredentials = AuthCredentials(
      email: email!,
      password: password,
    );
    emit(AuthState.confirmForgot);
  }
}
