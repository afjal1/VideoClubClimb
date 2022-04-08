import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepo {
  Future<String> getUserIDFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();

      final userID = attributes
          .firstWhere((element) => element.userAttributeKey.toString() == 'sub')
          .value;

      return userID;
    }on Exception catch (e) {

      throw Exception(e);
    }
  }

  Future<String?> attemptAutoLogin() async {

    try {
      final session = await Amplify.Auth.fetchAuthSession();

      if(session.isSignedIn == false){
        throw Exception(null);
      }

      String res= await getUserIDFromAttributes();
      return (res);

    }on Exception {

      rethrow;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {

    try {
      final res = await Amplify.Auth.signIn(
        username: email.trim(),
        password: password.trim(),
      );

      return res.isSignedIn? (await getUserIDFromAttributes()) : null;

    }on Exception catch (e){


      if(e is NotAuthorizedException){
        throw Exception('Email o crontraseña incorrecto');
      }

      if(e is UserNotFoundException){
        throw Exception('Email no registrado');
      }

      print(e);

      throw Exception('error de inicio de sesion');
    }
  }

  Future<bool> signup({
    required String email,
    required String password,
  }) async {

    try{
      final result = await Amplify.Auth.signUp(
        username: email.trim(),
        password: password.trim(),
        options: CognitoSignUpOptions(userAttributes: {CognitoUserAttributeKey.email: email.trim()}),
      );

      return result.isSignUpComplete;
    }
    on Exception catch (e){

      if(e is InvalidParameterException){
        throw Exception('Formato del Email incorrecto');
      }

      if(e is UsernameExistsException){
        throw Exception('Email ID ya registrado');
      }

      rethrow;
    }
  }

  Future<bool> confirmSignup({
    required String email,
    required String confirmationCode,
  }) async {
    try{
      final result = await Amplify.Auth.confirmSignUp(
        username: email.trim(),
        confirmationCode: confirmationCode.trim(),
      );

      return result.isSignUpComplete;
    }
    on Exception catch (e){
      if(e is CodeMismatchException){
        throw Exception(e.message);
      }

      throw Exception('Error confirming code');
    }
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }
}
