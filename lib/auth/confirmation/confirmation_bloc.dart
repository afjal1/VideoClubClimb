
import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

class ConfirmationBloc extends Bloc<ConfirmationEvent, ConfirmationState>{

  final AuthRepo authRepo;
  final AuthCubit authCubit;

  ConfirmationBloc({required this.authRepo, required this.authCubit}) : super(ConfirmationState()){

    on<ConfirmationCodeChangedEvent>((event, emit) => emit(state.copyWith(code: event.code)));
    on<ConfirmationButtonClicked>(_onConfirmationButtonClicked);

  }

  Future<FutureOr<void>> _onConfirmationButtonClicked(ConfirmationButtonClicked event, Emitter<ConfirmationState> emit) async {

    emit(state.copyWith(formSubmissionState: FormSubmitting()));

    try{
      await authRepo.confirmSignup(email: authCubit.authCredentials!.email, confirmationCode: state.code);

      emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));

      final authCredentials = authCubit.authCredentials!;

      try {
        final userID = await authRepo.login(
            email: authCredentials.email, password: authCredentials.password!);

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