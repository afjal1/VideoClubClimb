
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Media/Videos/video_state.dart';

import '../../data_repo.dart';
import '../../session_cubit.dart';


class VideosCubit extends Cubit<VideoState> {
  SessionCubit sessionCubit;
  DataRepo dataRepo;
  String category = '';

  VideosCubit({required this.sessionCubit, required this.dataRepo, })
      : super(InitialStateOfVideos());

  ///*********************** HomePage ***************///
  showInicio() => emit(ViewInicio());


  ///*********************** ZONE Menu/Videos ***************///
  showZoneMenu() => emit(ViewingZoneMenu());

  showZoneVideos(String category, int currentCategory) =>
      emit(ViewingZoneVideos(category: category, currentCategory: currentCategory));



  ///*********************** My Videos Menu/Videos ***************///
  showMyVideosMenu() => emit(ViewingMyVideosMenu());

  showMyVideos(String category, int currentCategory,String name) =>
      emit(ViewingMyVideos(category: category, currentCategory: currentCategory, name: name));


  ///************************UPLOAD Zone/Video *********************///
  showMenuUploadVideos() => emit(ViewingMenuUploadVideos());

  showUploadVideos({required String category}) {
    this.category = category;
    emit(ViewingUploadVideos());
  }


  ///************************  WatchVideo *********************///
  watchVideo({required String category, required String name, required String UIName,required String url}) =>
      emit(WatchingVideo(category: category, name: name, UIName: UIName, url: url));
}



