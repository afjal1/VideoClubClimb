import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/video_state.dart';
import 'package:videoclubclimb/Media/Videos/videos_cubit.dart';

import 'package:videoclubclimb/Pages/Homepage/homepage_ui.dart';
import 'package:videoclubclimb/Pages/My_videos/my_videos/my_videos_bloc.dart';
import 'package:videoclubclimb/Pages/My_videos/my_videos/my_videos_ui.dart';
import 'package:videoclubclimb/Pages/My_videos/my_videos_menu/my_videos_menu_bloc.dart';
import 'package:videoclubclimb/Pages/My_videos/my_videos_menu/my_videos_menu_ui.dart';
import 'package:videoclubclimb/Pages/Upload/upload_menu/upload_video_menu_bloc.dart';
import 'package:videoclubclimb/Pages/Upload/upload_menu/upload_video_menu_ui.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_bloc.dart';
import 'package:videoclubclimb/Pages/Upload/upload_video/upload_videos_ui.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_bloc.dart';
import 'package:videoclubclimb/Pages/Zone/zone_menu/zone_menu_ui.dart';
import 'package:videoclubclimb/Pages/Zone/zone_videos/zone_videos_bloc.dart';
import 'package:videoclubclimb/Pages/Zone/zone_videos/zone_videos_ui.dart';
import 'package:videoclubclimb/auth/auth_repo.dart';

import '../../data_repo.dart';

class VideosNavigator extends StatelessWidget {
  const VideosNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosCubit, VideoState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            ///*********************** HomePage ***************///
            if (state is InitialStateOfVideos)
              const MaterialPage(child: HomePage()),

            if (state is ViewInicio)
              const MaterialPage(
                child: HomePage(),
              ),

            ///*********************** ZONE Menu/Videos ***************///
            if (state is ViewingZoneMenu || state is WatchingVideo) ...[
              MaterialPage(
                child: BlocProvider(
                    create: (BuildContext context) =>
                        ZoneMenuBloc(dataRepo: context.read<DataRepo>()),
                    child: const ZoneMenu()),
              ),

              // ///************************ WatchingVideo *********************///
              // if (state is WatchingVideo)
              //   MaterialPage(
              //     child: BlocProvider(
              //       create: (BuildContext context) => WatchVideosBloc(
              //         dataRepo: context.read<DataRepo>(),
              //         category: state.category,
              //         name: state.name,
              //         UIName: state.UIName,
              //         url: state.url,
              //       ),
              //       child: WatchVideo(
              //         category: state.category,
              //         name: state.name,
              //         UIName: state.UIName,
              //         url: state.url,
              //       ),
              //     ),
              //   ),
            ],

            if (state is ViewingZoneVideos)
              MaterialPage(
                child: BlocProvider(
                  create: (BuildContext context) => ZoneVideosBloc(
                    dataRepo: context.read<DataRepo>(),
                    category: state.category,
                  ),
                  child: const ZoneVideo(),
                ),
              ),

            ///*********************** MY VIDEOS Zone/Videos ***************///
            if (state is ViewingMyVideosMenu) ...[
              MaterialPage(
                child: BlocProvider(
                    create: (BuildContext context) =>
                        MyVideosMenuBloc(dataRepo: context.read<DataRepo>()),
                    child: const MyVideosMenu()),
              ),
            ],

            if (state is ViewingMyVideos)
              MaterialPage(
                child: BlocProvider(
                  create: (BuildContext context) => MyVideosBloc(
                    dataRepo: context.read<DataRepo>(),
                    authRepo: context.read<AuthRepo>(),
                    category: state.category,
                  ),
                  child: const MyVideosUI(),
                ),
              ),

            ///************************UPLOAD Zone/Video *********************///
            if (state is ViewingMenuUploadVideos)
              MaterialPage(
                child: BlocProvider(
                  create: (BuildContext context) => UploadVideoMenuBloc(
                    dataRepo: context.read<DataRepo>(),
                  ),
                  child: const UploadVideoMenu(),
                ),
              ),

            if (state is ViewingUploadVideos)
              MaterialPage(
                child: BlocProvider(
                  create: (BuildContext context) => UploadVideoBloc(
                    dataRepo: context.read<DataRepo>(),
                  ),
                  child: const UploadVideo(),
                ),
              ),
          ],
          onPopPage: (route, result) {
            final page = route.settings as MaterialPage;

            if (page.child is HomePage) {}

            if (page.child is ZoneMenu) {}

            if (page.child is ZoneVideo) {}

            if (page.child is MyVideosMenu) {}

            // if (page.child is MyVideosUI) {}

            if (page.child is UploadVideoMenu) {}

            if (page.child is UploadVideo) {}

            //  if (page.child is WatchingVideo) {}

            return route.didPop(result);
          },
        );
      },
    );
  }
}
