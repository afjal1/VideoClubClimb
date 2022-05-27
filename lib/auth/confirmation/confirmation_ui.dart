import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../auth_cubit.dart';
import '../auth_repo.dart';
import '../form_submission_state.dart';
import 'confirmation_bloc.dart';
import 'confirmation_event.dart';
import 'confirmation_state.dart';

class ConfirmationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  ConfirmationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.orange,
      body: BlocProvider(
        create: (BuildContext context) => ConfirmationBloc(
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
    return BlocListener<ConfirmationBloc, ConfirmationState>(
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
              _codeField(),
              const SizedBox(height: 50),
              _confirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _codeField() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(
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
                  fontSize: size.width * 0.0513,
              ),
              floatingLabelStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: size.width * 0.0513,
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
              .read<ConfirmationBloc>()
              .add(ConfirmationCodeChangedEvent(code: value)),
        );
      },
    );
  }


  Widget _confirmButton() {
    return BlocBuilder<ConfirmationBloc, ConfirmationState>(builder: (context, state) {
      if (state.formSubmissionState is FormSubmitting) {

        return const CircularProgressIndicator(
          color: Colors.teal,
        );
      } else {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.teal,
            onPrimary: Colors.white,
            elevation: MediaQuery.of(context).size.height* 0.0417,
          ),
          autofocus: true,
          child: const Text('Confirmar cuenta'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              context.read<ConfirmationBloc>().add(ConfirmationButtonClicked());
            }
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
