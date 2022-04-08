import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_repo.dart';
import '../session_cubit.dart';
import 'Videos/videos_cubit.dart';
import 'Videos/videos_navigator.dart';
import 'media_cubit.dart';
import 'media_state.dart';


class MediaNavigator extends StatelessWidget {
  const MediaNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MediaCubit, MediaState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is VideosSession)
              MaterialPage(
                child: BlocProvider(
                    create: (BuildContext context) => VideosCubit(
                        sessionCubit: context.read<SessionCubit>(),
                        dataRepo: context.read<DataRepo>(),
                        ),

                    child: const VideosNavigator()),
              ),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
