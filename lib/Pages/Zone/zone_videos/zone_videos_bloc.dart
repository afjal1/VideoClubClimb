import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/models/File.dart';

import '../../../data_repo.dart';
import 'zone_videos_event.dart';
import 'zone_videos_state.dart';

class ZoneVideosBloc extends Bloc<ZoneVideosEvent, ZoneVideosState> {
  DataRepo dataRepo;
  String category = "";

  ZoneVideosBloc({
    required this.dataRepo,
    required this.category,
  }) : super(ZoneVideosState(
          files: [],
          categories: [],
          searchedVideos: [],
          images: [],
          videoUrls: [],
        )) {
    on<DeleteVideoZoneButtonClickedEvent>(_onDeleteVideoButtonClickedEvent);
    // on<CategoryClickedZoneVideosEvent>(_getVideosInACategoryZoneVideo);
    on<GetZoneVideosEvent>(_getZoneVideos);
    // on<GetZoneVideosEventGRADO>(_getVideoZoneGRADO);
    on<ToggleSearching>(_toggleSearching);
    on<SearchKeywordChanged>(_searchKeywordChanged);
    on<Search>(_search);
    on<SearchByEvent>(_searchByChanged);

    on<GetVideoFiles>(_getVideoFiles);
    on<DeleteAllCategoryVideo>(_deleteAllCategory);
  }

  FutureOr<void> _onDeleteVideoButtonClickedEvent(
    DeleteVideoZoneButtonClickedEvent event,
    Emitter<ZoneVideosState> emit,
  ) async {
    // List<String> videos = await dataRepo.getSectorVideos(category);
    //
    // await dataRepo.deleteVideo(category, videos[event.index]);
    // await dataRepo.listItemsSectoresVideos();
    //
    // videos = await dataRepo.getSectorVideosForUI(category);
    // emit(state.copyWith(
    //   totalVideos: videos.length,
    //   videos: videos,
    // ));
  }

  // FutureOr<void> _getVideosInACategoryZoneVideo(
  //     CategoryClickedZoneVideosEvent event, Emitter<ZoneVideosState> emit) {
  //   emit(state.copyWith(currentCategory: event.categoryIndex));
  //   if (event.categoryIndex != -1) {
  //     String categoryName = state.categories[state.currentCategory];
  //
  //     List<String> tempVideos =
  //         dataRepo.getVideoForUISectoresMenu(categoryName);
  //
  //     List<String> videos = [];
  //     String keyword = state.searchedKeyword;
  //     for (int i = 0; i < tempVideos.length; i++) {
  //       if (tempVideos[i].contains(keyword)) {
  //         videos.add(tempVideos[i]);
  //       }
  //     }
  //
  //     List<String> tempVideosNames =
  //         dataRepo.getVideoNamesSectoresMenu(categoryName);
  //     List<String> videosNames = [];
  //
  //     for (int i = 0; i < tempVideosNames.length; i++) {
  //       if (tempVideosNames[i].contains(keyword)) {
  //         videosNames.add(tempVideosNames[i]);
  //       }
  //     }
  //
  //     if (keyword.isNotEmpty) {
  //       emit(state.copyWith(totalVideosInCurrentCategory: videos.length));
  //       emit(state.copyWith(videos: videos, videosNames: videosNames));
  //     } else {
  //       emit(state.copyWith(totalVideosInCurrentCategory: tempVideos.length));
  //       emit(state.copyWith(videos: tempVideos, videosNames: tempVideosNames));
  //     }
  //   }
  // }

  FutureOr<void> _getZoneVideos(
      GetZoneVideosEvent event, Emitter<ZoneVideosState> emit) async {
    // emit(state.copyWith(formSubmissionState: FormSubmitting()));

    // List<File> files = await dataRepo.listFilesByCategory(category);

    // emit(state.copyWith(totalFiles: files.length, files: files));
    // emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));
  }

  // FutureOr<void> _getVideoZoneGRADO(GetZoneVideosEventGRADO event, Emitter<ZoneVideosState> emit) async {
  //   List<String> grados = await dataRepo.getVideosGrado(category);
  //   emit(state.copyWith(totalGrados: grados.length, grados: grados, ));
  // }

  FutureOr<void> _toggleSearching(
      ToggleSearching event, Emitter<ZoneVideosState> emit) {
    if (state.isSearching) {
      emit(state.copyWith(isSearching: false));
    } else {
      emit(state.copyWith(isSearching: true));
    }
  }

  FutureOr<void> _searchKeywordChanged(
      SearchKeywordChanged event, Emitter<ZoneVideosState> emit) {
    emit(state.copyWith(searchedKeyword: event.value));
  }

  FutureOr<void> _search(Search event, Emitter<ZoneVideosState> emit) {
    emit(FormSubmitting1(
        files: [],
        images: [],
        videoUrls: [],
        categories: [],
        searchedVideos: []));
    List<File> searchedVideos = [];
    List<String>? searchImages = [];
    List<String>? searchVideoUrls = [];

    if (state.searchBy == SearchBy.name) {
      for (int i = 0; i < state.files.length; i++) {
        if (state.files[i].name!.contains(state.searchedKeyword)) {
          searchedVideos.add(state.files[i]);
          searchImages.add(state.images[i]);
          searchVideoUrls.add(state.videoUrls[i]);
        }
      }
    } else if (state.searchBy == SearchBy.grado) {
      int grade = mapGradeToIndex(event.grado);

      for (int i = 0; i < state.files.length; i++) {
        if (state.files[i].grade == grade) {
          searchedVideos.add(state.files[i]);
          searchImages.add(state.images[i]);
          searchVideoUrls.add(state.videoUrls[i]);
        }
      }
    }

    emit(
      state.copyWith(
        totalVideos: searchedVideos,
        searchImages: searchImages,
        searchVideoUrls: searchVideoUrls,
      ),
    );
  }

  FutureOr<void> _searchByChanged(
      SearchByEvent event, Emitter<ZoneVideosState> emit) {
    emit(state.copyWith(searchBy: event.searchBy));
  }

  FutureOr<void> _getVideoFiles(
    GetVideoFiles event,
    Emitter<ZoneVideosState> emit,
  ) async {
    try {
      emit(FormSubmitting1(
          files: [],
          images: [],
          videoUrls: [],
          categories: [],
          searchedVideos: []));

      List<File> files =
          await dataRepo.listFilesByCategory(category, event.page, event.limit);
      List<String> images = [];
      List<String> url = [];

      for (int i = 0; i < files.length; i++) {
        String link = await dataRepo.getPhotoLink(files[i]);
        images.add(link);
      }

      for (int i = 0; i < files.length; i++) {
        String link = await dataRepo.getVideoLink(files[i]);
        url.add(link);
      }

      emit(state.copyWith(
          totalFiles: files.length,
          files: files,
          images: images,
          videoUrls: url,
          firstFetch: true));

      //   emit(state.copyWith(formSubmissionState: FormSubmissionSuccessful()));
    } catch (e) {}
  }

  Future<void> _deleteAllCategory(
      DeleteAllCategoryVideo event, Emitter<ZoneVideosState> emit) async {
    emit(FormSubmitting1(
        files: [],
        images: [],
        videoUrls: [],
        categories: [],
        searchedVideos: []));
    await dataRepo.deleteAllCategory(category);
  }
}

int mapGradeToIndex(String? newValue) {
  int gradoIndex = 0;

  if (newValue == '4') {
    gradoIndex = 0;
  } else if (newValue == '5') {
    gradoIndex = 1;
  } else if (newValue == '5+') {
    gradoIndex = 2;
  } else if (newValue == '6a') {
    gradoIndex = 3;
  } else if (newValue == '6a+') {
    gradoIndex = 4;
  } else if (newValue == '6b') {
    gradoIndex = 5;
  } else if (newValue == '6b+') {
    gradoIndex = 6;
  } else if (newValue == '6c') {
    gradoIndex = 7;
  } else if (newValue == '6c+') {
    gradoIndex = 8;
  } else if (newValue == '7a') {
    gradoIndex = 9;
  } else if (newValue == '7a+') {
    gradoIndex = 10;
  } else if (newValue == '7b') {
    gradoIndex = 11;
  } else if (newValue == '7b+') {
    gradoIndex = 12;
  }

  return gradoIndex;
}
