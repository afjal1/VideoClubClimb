import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.orange,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.orange,
      body: BlocProvider(
        create: (BuildContext context) => LoginBloc(
          authRepo: context.read<AuthRepo>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _loginForm(),
            _signupButton(context),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formSubmissionState = state.formSubmissionState;
        if (formSubmissionState is FormSubmissionFailed) {
          _showSnackBar(context, formSubmissionState.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _emailField(),
              const SizedBox(
                height: 30,
              ),
              _passwordField(),
              _forgotButton(),
              const SizedBox(height: 6),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        Size size = MediaQuery.of(context).size;

        return TextFormField(
          keyboardType: TextInputType.emailAddress, //tipo de teclado
          cursorColor: Colors.white,

          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Email',
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
              Icons.person,
              color: Colors.white,
            ),
            hintText: 'Email',
            hintStyle: const TextStyle(color: Colors.transparent),
          ),
          validator: (value) =>
              state.isValidEmail ? null : 'Direcci??n Email no valida',
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginUsernameChangedEvent(email: value)),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, state) {
        Size size = MediaQuery.of(context).size;

        return TextFormField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress, //tipo de teclado
          cursorColor: Colors.white,

          style: const TextStyle(color: Colors.white),

          decoration: InputDecoration(
            labelText: 'Contrase??a',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.0513,
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.blue,
              fontSize: size.width * 0.0513,
            ),
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
            hintText: 'Contrase??a',
            hintStyle: const TextStyle(color: Colors.transparent),
          ),
          validator: (value) => state.isValidPassword
              ? null
              : 'La contrase??a necesita m??nimo 8 car??cteres',
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(LoginPasswordChangedEvent(password: value)),
        );
      },
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state.formSubmissionState is FormSubmitting) {
        return const CircularProgressIndicator(
          color: Colors.teal,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            elevation: MediaQuery.of(context).size.height * 0.0067,
          ),
          autofocus: true,
          child: const Text('Iniciar sesion'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<LoginBloc>().add(LoginButtonClicked());
            }
          },
        );
      }
    });
  }

  Widget _signupButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.0134),
        child: TextButton(
          child: Text(
            '??No tienes cuenta? Registrate',
            style:
                TextStyle(color: Colors.white, fontSize: size.width * 0.05415),
          ),
          onPressed: () {
            context.read<AuthCubit>().showSignup();
          },
        ),
      ),
    );
  }

  Widget _forgotButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      Size size = MediaQuery.of(context).size;

      return Container(
        margin:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.3056),
        child: TextButton(
          child: Text(
            '??Olvidaste la contrase??a?',
            style:
                TextStyle(color: Colors.white, fontSize: size.width * 0.03705),
          ),
          onPressed: () {
            context.read<AuthCubit>().showForgot();
          },
        ),
      );
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
