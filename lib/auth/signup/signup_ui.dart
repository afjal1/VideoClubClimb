import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              SizedBox(height: 30,),
              _passwordField(),
              const SizedBox(height: 50),
              _signupButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (BuildContext context, state) {
        return TextFormField(
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.white,

          style:  TextStyle(color: Colors.white),

          decoration:  InputDecoration(
            errorStyle: TextStyle(
              color: Colors.white,
            ),

            labelText: 'Email',
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
            floatingLabelStyle: TextStyle(
                color: Colors.blue,
                fontSize: 18
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),

            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.blue
                )
            ),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),

            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),

            hintText: 'Email',
            hintStyle: TextStyle(color: Colors.transparent),
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
        return TextFormField(
          obscureText: true,
          keyboardType: TextInputType.emailAddress, //tipo de teclado
          cursorColor: Colors.white,

          style:  TextStyle(color: Colors.white),

          decoration:  InputDecoration(

            labelText: 'Contraseña',
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 18
            ),
            floatingLabelStyle: TextStyle(
                color: Colors.blue,
                fontSize: 18
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,

            errorStyle: TextStyle(
              color: Colors.white,
            ),

            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),

            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.blue
                )
            ),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                    color: Colors.white
                )
            ),
            prefixIcon: Icon(
              Icons.security,
              color: Colors.white,
            ),

            hintText: 'Contraseña',
            hintStyle: TextStyle(color: Colors.transparent),

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
            elevation: 5,
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
    return SafeArea(
      child: TextButton(
        child: const Text(
          '¿Ya tienes cuenta? Iniciar sesión',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        onPressed: () {
          context.read<AuthCubit>().showLogin();
        },
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
