import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:videoclubclimb/auth/auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState>{

  final AuthRepo authRepo;
  final AuthCubit authCubit;


  SignupBloc({required this.authCubit, required this.authRepo}): super(SignupState()) {
    on<SignupUsernameChangedEvent>((event, emit) => emit(state.copyWith(email: event.email)));
    on<SignupPasswordChangedEvent>((event, emit) => emit(state.copyWith(password: event.password)));
    on<SignupButtonClicked>(_onSignupClicked);
  }

  Future<FutureOr<void>> _onSignupClicked(SignupButtonClicked event, Emitter<SignupState> emit) async {
    emit(state.copyWith(formSubmissionState: FormSubmitting()));

    try{
      await authRepo.signup(email: state.email, password: state.password);

      emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));

      authCubit.showConfirmation(email: state.email, password: state.password);

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