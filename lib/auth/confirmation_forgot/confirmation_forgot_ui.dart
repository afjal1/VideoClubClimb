import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'confirmation_forgot_bloc.dart';
import 'confirmation_forgot_event.dart';
import 'confirmation_forgot_state.dart';

class ConfirmationForgotPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ConfirmationForgotPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.orange,
      body: BlocProvider(
        create: (BuildContext context) => ConfirmationForgotBloc(
          authRepo: context.read<AuthRepo>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _confirmationForm(),
          ],
        ),
      ),
    );
  }

  Widget _confirmationForm() {
    return BlocListener<ConfirmationForgotBloc, ConfirmationForgotState>(
      listener: (context, state) {
        final formSubmissionState = state.formSubmissionState;
        if (formSubmissionState is FormSubmissionFailed) {
          _showSnackBar(context, formSubmissionState.exception.toString());
        }
      },
      child: Builder(
        builder: (context) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width* 0.1111),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height* 0.0403),
                  _newPass(),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.0672),
                  _codeField(),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.0672),
                  _confirmButton(),
                  SizedBox(height: MediaQuery.of(context).size.height* 0.0134),
                  _backButton(),
                ],
              ),
            ),
          );
        }
      ),
    );
  }


  Widget _newPass() {
    return BlocBuilder<ConfirmationForgotBloc, ConfirmationForgotState>(
      builder: (BuildContext context, state) {
        Size size = MediaQuery.of(context).size;
        return TextFormField(
          keyboardType: TextInputType.number, //tipo de teclado
          cursorColor: Colors.white,

          style: TextStyle(color: Colors.white),
          decoration:  InputDecoration(

            labelText: 'Nueva contraseña',
            labelStyle: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.0513
            ),
            floatingLabelStyle: TextStyle(
                color: Colors.blue,
                fontSize: size.width * 0.0513
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
              Icons.keyboard,
              color: Colors.white,
            ),

            hintText: 'Nuevqa contraseña',
            hintStyle: TextStyle(color: Colors.transparent),

          ),
          validator: (value) =>
          state.isValidPass ? null : 'La contraseña debe tener mínimo 8 dígitos',
          onChanged: (value) => context
              .read<ConfirmationForgotBloc>()
              .add(NewPassChangedEvent(newpass: value)),
        );
      },
    );
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmationForgotBloc, ConfirmationForgotState>(
      builder: (BuildContext context, state) {
        Size size = MediaQuery.of(context).size;
        return TextFormField(
            keyboardType: TextInputType.number, //tipo de teclado
            cursorColor: Colors.white,

            style: TextStyle(color: Colors.white),
            decoration:  InputDecoration(

              labelText: 'Código de confirmación',
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.0513
              ),
              floatingLabelStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: size.width * 0.0513
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
                Icons.keyboard,
                color: Colors.white,
              ),

              hintText: 'Código de confirmación',
              hintStyle: TextStyle(color: Colors.transparent),

            ),
          validator: (value) =>
              state.isValidCode ? null : 'El código de confirmación debe tener 6 dígitos',
          onChanged: (value) => context
              .read<ConfirmationForgotBloc>()
              .add(ConfirmationCodeChangedEvent(code: value)),
        );
      },
    );
  }

  Widget _confirmButton() {
    return BlocBuilder<ConfirmationForgotBloc, ConfirmationForgotState>(builder: (context, state) {
      if (state.formSubmissionState is FormSubmitting) {
        return const CircularProgressIndicator(
          color: Colors.teal,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            elevation: MediaQuery.of(context).size.height* 0.0067,
          ),
          autofocus: true,
          child: const Text('Confirmar contreaseña'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ConfirmationForgotBloc>().add(ConfirmationButtonClicked());
            }
            context.read<AuthCubit>().showSignup();

          },

        );
      }
    });
  }

  Widget _backButton() {
    return BlocBuilder<ConfirmationForgotBloc, ConfirmationForgotState>(builder: (context, state) {
      if (state.formSubmissionState is FormSubmitting) {
        return const CircularProgressIndicator(
          color: Colors.transparent,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            elevation: MediaQuery.of(context).size.height* 0.0067,
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

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
