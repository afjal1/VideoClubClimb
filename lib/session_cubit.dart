

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/session_state.dart';

import 'auth/auth_credentials.dart';
import 'auth/auth_repo.dart';





class SessionCubit extends Cubit<SessionState>{
  final AuthRepo authRepo;


  SessionCubit({required this.authRepo}) : super(UnknownSessionState()){
    // signOut();
    attemptAutoLogin();
  }


  attemptAutoLogin() async {
    try{

      String? temp= await authRepo.attemptAutoLogin();
      final userID = temp.toString();

      // if(userID == null){
      //   emit(UnauthenticatedSessionState());
      //
      //   return;
      // }

      final user = userID;

      emit(AuthenticatedSessionState(user: user));
    }
    on Exception{
        emit(UnauthenticatedSessionState());
    }
  }

  showAuth() => emit(UnauthenticatedSessionState());
  showSession(AuthCredentials authCredentials) {

    // TODO -- user = dataRepo.getUser(authCredentials.userID);
    final user = authCredentials.email;

    emit(AuthenticatedSessionState(user: user));
  }

  void signOut(){
    authRepo.signOut();
    emit(UnauthenticatedSessionState());
  }
}