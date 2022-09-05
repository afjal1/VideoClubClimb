import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/auth/signup/signup_bloc.dart';
import 'package:videoclubclimb/auth/signup/signup_event.dart';
import 'package:videoclubclimb/auth/signup/signup_state.dart';

import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';

class SignupPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.orange,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.orange,
      body: BlocProvider(
        create: (BuildContext context) => SignupBloc(
          authRepo: context.read<AuthRepo>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _signupForm(),
            _loginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _signupForm() {
    return BlocListener<SignupBloc, SignupState>(
      listener: (BuildContext context, state) {
        final formSubmissionState = state.formSubmissionState;
        if (formSubmissionState is FormSubmissionFailed) {
          _showSnackBar(context, formSubmissionState.exception.toString());
        }
      },
      child: Builder(builder: (context) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.0538),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emailField(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.0403,
                ),
                _passwordField(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0672),
                _signupButton(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (BuildContext context, state) {
        Size size = MediaQuery.of(context).size;
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            errorStyle: const TextStyle(
              color: Colors.white,
            ),
            labelText: 'Email',
            labelStyle:
                TextStyle(color: Colors.white, fontSize: size.width * 0.0513),
            floatingLabelStyle:
                TextStyle(color: Colors.blue, fontSize: size.width * 0.0513),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white)),
            prefixIcon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.transparent),
          ),
          validator: (value) =>
              state.isValidEmail ? null : 'Dirección Email no valida',
          onChanged: (value) => context
              .read<SignupBloc>()
              .add(SignupUsernameChangedEvent(email: value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (BuildContext context, state) {
        Size size = MediaQuery.of(context).size;

        return TextFormField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress, //tipo de teclado
          cursorColor: Colors.white,

          style: const TextStyle(color: Colors.white),

          decoration: InputDecoration(
            labelText: 'Contraseña',
            labelStyle:
                TextStyle(color: Colors.white, fontSize: size.width * 0.0513),
            floatingLabelStyle:
                TextStyle(color: Colors.blue, fontSize: size.width * 0.0513),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            errorStyle: const TextStyle(
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white)),
            prefixIcon: const Icon(
              Icons.security,
              color: Colors.white,
            ),
            hintText: 'Contraseña',
            hintStyle: const TextStyle(color: Colors.transparent),
          ),

          validator: (value) => state.isValidPassword
              ? null
              : 'La contraseña necesita mínimo 8 carácteres',
          onChanged: (value) => context
              .read<SignupBloc>()
              .add(SignupPasswordChangedEvent(password: value)),
        );
      },
    );
  }

  Widget _signupButton() {
    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
      if (state.formSubmissionState is FormSubmitting) {
        return const CircularProgressIndicator(
          color: Colors.orangeAccent,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            elevation: MediaQuery.of(context).size.height * 0.0067,
          ),
          autofocus: true,
          child: const Text('Registrarse'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<SignupBloc>().add(SignupButtonClicked());
            }
          },
        );
      }
    });
  }

  Widget _loginButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.0134),
        child: TextButton(
          child: Text(
            '¿Ya tienes cuenta? Iniciar sesión',
            style:
                TextStyle(color: Colors.white, fontSize: size.width * 0.05415),
          ),
          onPressed: () {
            context.read<AuthCubit>().showLogin();
          },
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
