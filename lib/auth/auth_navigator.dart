import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/auth/signup/signup_ui.dart';

import 'auth_cubit.dart';
import 'confirmation/confirmation_ui.dart';
import 'login/login_ui.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, state) {
        return Navigator(
          pages: [
            if (state == AuthState.login) MaterialPage(child: LoginPage()),
            if (state == AuthState.signup ||
                state == AuthState.confirmSignup) ...[
              MaterialPage(child: SignupPage()),
              if (state == AuthState.confirmSignup)
                MaterialPage(child: ConfirmationPage()),
            ],
          ],
          onPopPage: (route, result) {

            final page = route.settings as MaterialPage;
            if(page.child is ConfirmationPage) {
              context.read<AuthCubit>().showSignup();
            }
            return route.didPop(result);
          },
        );
      },
    );
  }
}
