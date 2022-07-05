
import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'confirmation_forgot_event.dart';
import 'confirmation_forgot_state.dart';

class ConfirmationForgotBloc extends Bloc<ConfirmationForgotEvent, ConfirmationForgotState>{

  final AuthRepo authRepo;
  final AuthCubit authCubit;

  ConfirmationForgotBloc({required this.authRepo, required this.authCubit}) : super(ConfirmationForgotState()){

    on<ConfirmationCodeChangedEvent>((event, emit) => emit(state.copyWith(code: event.code)));
    on<NewPassChangedEvent>((event, emit) => emit(state.copyWith(newpass: event.newpass)));
    on<ConfirmationButtonClicked>(_onConfirmationButtonClicked);
  }

  Future<FutureOr<void>> _onConfirmationButtonClicked(ConfirmationButtonClicked event, Emitter<ConfirmationForgotState> emit) async {

    emit(state.copyWith(formSubmissionState: FormSubmitting()));

    try{
      await authRepo.confirmForgot(email: authCubit.authCredentials!.email, confirmationCode: state.code, newpassword: state.newpass);

      emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));

      final authCredentials = authCubit.authCredentials!;

      try {
        final userID = await authRepo.login(
            email: authCredentials.email, password: state.newpass);

        authCredentials.userID = userID;

        authCubit.showSession(authCredentials);
      }
      catch (exception){
        emit(state.copyWith(formSubmissionState: FormSubmissionFailed(exception as Exception)));
        emit(state.copyWith(formSubmissionState: const InitialFormState()));
      }

      emit(state.copyWith(formSubmissionState: const InitialFormState()));
    }

    catch (exception){
      emit(state.copyWith(formSubmissionState: FormSubmissionFailed(exception as Exception)));
      emit(state.copyWith(formSubmissionState: const InitialFormState()));
    }
  }
}