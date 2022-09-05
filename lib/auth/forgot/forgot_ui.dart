import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'forgot_bloc.dart';
import 'forgot_event.dart';
import 'forgot_state.dart';

class ForgotPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.orange,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      backgroundColor: Colors.orange,
      body: BlocProvider(
        create: (BuildContext context) => ForgotBloc(
          authRepo: context.read<AuthRepo>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _forgotForm(),
            _login_tButton(context),
          ],
        ),
      ),
    );
  }

  Widget _forgotForm() {
    return BlocListener<ForgotBloc, ForgotState>(
      listener: (context, state) {
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
                horizontal: MediaQuery.of(context).size.width * 0.1111),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.0134),
                _emailField(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0672),
                _forgotButton(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0134),
                _backButton(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _emailField() {
    return BlocBuilder<ForgotBloc, ForgotState>(
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
              state.isValidEmail ? null : 'Dirección Email no valida',
          onChanged: (value) => context
              .read<ForgotBloc>()
              .add(ForgotUsernameChangedEvent(email: value)),
        );
      },
    );
  }

  Widget _forgotButton() {
    return BlocBuilder<ForgotBloc, ForgotState>(builder: (context, state) {
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
          child: const Text('Reiniciar contraseña'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ForgotBloc>().add(ForgotButtonClicked());
            }
          },
        );
      }
    });
  }

  Widget _backButton() {
    return BlocBuilder<ForgotBloc, ForgotState>(builder: (context, state) {
      if (state.formSubmissionState is FormSubmitting) {
        return const CircularProgressIndicator(
          color: Colors.transparent,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            elevation: MediaQuery.of(context).size.height * 0.0067,
          ),
          autofocus: true,
          child: const Text('Atras'),
          onPressed: () {
            context.read<AuthCubit>().showLogin();
          },
        );
      }
    });
  }

  Widget _login_tButton(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.0134,
        ),
        child: TextButton(
          child: Text(
            '¿No tienes cuenta? Registrate',
            style:
                TextStyle(color: Colors.white, fontSize: size.width * 0.04845),
          ),
          onPressed: () {
            context.read<AuthCubit>().showSignup();
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
