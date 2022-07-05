import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_credentials.dart';
import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'forgot_event.dart';
import 'forgot_state.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  final AuthRepo authRepo;
  final AuthCubit authCubit;

  ForgotBloc({required this.authCubit, required this.authRepo}) : super(ForgotState()) {
    on<ForgotUsernameChangedEvent>((event, emit) => emit(state.copyWith(email: event.email)));
    on<ForgotButtonClicked>(_onForgotClicked);
  }

  Future<FutureOr<void>> _onForgotClicked(ForgotButtonClicked event, Emitter<ForgotState> emit) async {
    emit(state.copyWith(formSubmissionState: FormSubmitting()));

    try{
      await authRepo.forgot(email: state.email);

      emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));

      authCubit.showConfirmationForgot(email: state.email);

      emit(state.copyWith(email: ''));
      emit(state.copyWith(formSubmissionState: const InitialFormState()));
    }
    catch (exception){
      emit(state.copyWith(formSubmissionState: FormSubmissionFailed(exception as Exception)));
      emit(state.copyWith(formSubmissionState: const InitialFormState()));
    }
  }
}