import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/session_cubit.dart';
import 'package:videoclubclimb/session_state.dart';

import 'auth/auth_cubit.dart';
import 'auth/auth_navigator.dart';
import 'data_repo.dart';
import 'package:videoclubclimb/Media/media_cubit.dart';
import 'Media/media_navigator.dart';
import 'loading_view.dart';


class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is UnknownSessionState)
              const MaterialPage(child: LoadingView()),

            if (state is UnauthenticatedSessionState)
              MaterialPage(
                  child: BlocProvider(
                create: (BuildContext context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                     child: const AuthNavigator(),
              )),

            if (state is AuthenticatedSessionState)
              MaterialPage(
                  child: RepositoryProvider(
                    create: (BuildContext context) => DataRepo(),
                    child: BlocProvider(
                      create: (BuildContext context) =>
                          MediaCubit(sessionCubit: context.read<SessionCubit>()),
                      child: const MediaNavigator(),
                    ),
                  )),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
