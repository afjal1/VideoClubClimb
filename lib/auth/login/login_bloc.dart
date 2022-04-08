import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_credentials.dart';
import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  final AuthRepo authRepo;
  final AuthCubit authCubit;


  LoginBloc({required this.authCubit, required this.authRepo}): super(LoginState()) {
    on<LoginUsernameChangedEvent>((event, emit) => emit(state.copyWith(email: event.email)));
    on<LoginPasswordChangedEvent>((event, emit) => emit(state.copyWith(password: event.password)));
    on<LoginButtonClicked>(_onLoginClicked);
  }

  Future<FutureOr<void>> _onLoginClicked(LoginButtonClicked event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formSubmissionState: FormSubmitting()));

    try{
      final userID = await authRepo.login(email: state.email, password: state.password);

      emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));

      authCubit.showSession(AuthCredentials(
        email: state.email,
        userID: userID,
      ));

      emit(state.copyWith(email: ''));
      emit(state.copyWith(password: ''));
      emit(state.copyWith(formSubmissionState: const InitialFormState()));

    }
    catch (exception){
      emit(state.copyWith(formSubmissionState: FormSubmissionFailed(exception as Exception)));

      emit(state.copyWith(formSubmissionState: const InitialFormState()));
    }
  }
}