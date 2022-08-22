import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/auth/auth_repo.dart';
import 'package:videoclubclimb/models/File.dart';
import 'package:videoclubclimb/models/FileType.dart';

import '../../../data_repo.dart';
import 'my_videos_event.dart';
import 'my_videos_state.dart';

final List<File> item = [
  File(
      name: "null",
      type: FileType.PHOTOS,
      category: "null",
      description: " null",
      ownerID: "null",
      grade: 1020,
      s3key: "null",
      picsS3key: "null")
];

class MyVideosBloc extends Bloc<MyVideosEvent, MyVideosState> {
  DataRepo dataRepo;
  AuthRepo authRepo;
  String category = "";

  MyVideosBloc(
      {required this.dataRepo, required this.category, required this.authRepo})
      : super(MyVideosState(items: item, urls: [], categories: category)) {
    on<DeleteVideoButtonClickedEvent>(_onDeleteVideoButtonClickedEvent);
    on<VideoPlayButtonClickedEvent>(_playVideo);
    on<LoadMyVideosEvent>(_load);
    on<DeleteEverythingEvent>(_deleteAll);
    // on<GetMyVideosEvent>(_getMyVideos);
    //
    // on<CategoryClickedMyVideosEvent>(_getVideosInACategoryMyVideos);
    // on<GetMyVideosEventGRADO>(_getMyVideoEventGRADO);
  }

  FutureOr<void> _onDeleteVideoButtonClickedEvent(
      DeleteVideoButtonClickedEvent event, Emitter<MyVideosState> emit) async {
    dataRepo.deleteFile(state.items.elementAt(event.index));

    emit(state.copyWith());
  }

  Future<void> _playVideo(
      VideoPlayButtonClickedEvent event, Emitter<MyVideosState> emit) async {}

  Future<void> _load(
      LoadMyVideosEvent event, Emitter<MyVideosState> emit) async {
    emit(MyVideoFormSubmitting(items: [], categories: '', urls: []));
    String id = await authRepo.getUserIDFromAttributes();
    List<File> items = await dataRepo.listMyFilesByCategory(id, category);
    List<String> urls = [];
    for (int index = 0; index < items.length; index++) {
      urls.add(await dataRepo.getPhotoLink(items.elementAt(index)));
    }

    state.items.clear();
    emit(state.copyWith(items: items, urls: urls));
  }

  Future<void> _deleteAll(
      DeleteEverythingEvent event, Emitter<MyVideosState> emit) async {
    String id = await authRepo.getUserIDFromAttributes();
    await dataRepo.deleteCategory(category, id);
  }

  //
  // FutureOr<void> _getMyVideos(GetMyVideosEvent event, Emitter<MyVideosState> emit) async {
  //   List<String> videos = await dataRepo.getMyVideosForUI(category);
  //
  //   emit(state.copyWith(totalVideos: videos.length, videos: videos));
  // }
  //
  // FutureOr<void> _getVideosInACategoryMyVideos(CategoryClickedMyVideosEvent event, Emitter<MyVideosState> emit) {
  //   emit(state.copyWith(currentCategory: event.categoryIndex));
  //   if(event.categoryIndex != -1) {
  //
  //     String categoryName = state.categories[state.currentCategory];
  //
  //     List<String> tempVideos = dataRepo.getVideoForUISectoresMenu(categoryName);
  //
  //     List<String> videos = [];
  //     String keyword = state.searchedKeyword;
  //     for(int i = 0; i < tempVideos.length; i++){
  //       if(tempVideos[i].contains(keyword)){
  //         videos.add(tempVideos[i]);
  //       }
  //     }
  //
  //     List<String> tempVideosNames = dataRepo.getVideoNamesSectoresMenu(categoryName);
  //     List<String> videosNames = [];
  //
  //     for(int i = 0; i < tempVideosNames.length; i++){
  //       if(tempVideosNames[i].contains(keyword)){
  //         videosNames.add(tempVideosNames[i]);
  //       }
  //     }
  //
  //     if(keyword.isNotEmpty) {
  //       emit(state.copyWith(totalVideosInCurrentCategory: videos.length));
  //       emit(state.copyWith(videos: videos, videosNames: videosNames));
  //     }
  //     else{
  //       emit(state.copyWith(totalVideosInCurrentCategory: tempVideos.length));
  //       emit(state.copyWith(videos: tempVideos, videosNames: tempVideosNames));
  //     }
  //   }
  // }
  //
  // FutureOr<void> _getMyVideoEventGRADO(GetMyVideosEventGRADO event, Emitter<MyVideosState> emit) async {
  //   List<String> grados = await dataRepo.getVideosGrado(category);
  //   emit(state.copyWith(totalGrados: grados.length, grados: grados, ));
  // }

}
