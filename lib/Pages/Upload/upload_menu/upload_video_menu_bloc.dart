import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Pages/Upload/upload_menu/upload_video_menu_event.dart';
import 'package:videoclubclimb/Pages/Upload/upload_menu/upload_video_menu_state.dart';

import '../../../data_repo.dart';



class UploadVideoMenuBloc extends Bloc<UploadVideoMenuEvent, UploadVideoMenuState>{

  DataRepo dataRepo;

  UploadVideoMenuBloc({required this.dataRepo}) : super(UploadVideoMenuState(categories: [], videos: [], videosNames: [])){

    on<CategoryClickedUploadVideoMenuEvent>(_getVideosInACategoryUploadVideoMenu);
    on<GetCategoriesUploadVideoMenuEvent>(_getCategoriesUploadVideoMenu);
  }


  _getCategoriesUploadVideoMenu(GetCategoriesUploadVideoMenuEvent event, Emitter<UploadVideoMenuState> emit) async {

    await dataRepo.listItems();
    List<String> categories = await dataRepo.getCategoriesSectoresMenu();

    emit(state.copyWith(totalCategories: categories.length, categories: categories));
  }


  FutureOr<void> _getVideosInACategoryUploadVideoMenu(CategoryClickedUploadVideoMenuEvent event, Emitter<UploadVideoMenuState> emit) {

    emit(state.copyWith(currentCategory: event.categoryIndex));
    if(event.categoryIndex != -1) {

      String categoryName = state.categories[state.currentCategory];

      List<String> tempVideos = dataRepo.getVideoForUISectoresMenu(categoryName);
      List<String> videos = [];
      String keyword = state.searchedKeyword;
      for(int i = 0; i < tempVideos.length; i++){
        if(tempVideos[i].contains(keyword)){
          videos.add(tempVideos[i]);
        }
      }

      List<String> tempVideosNames = dataRepo.getVideoNamesSectoresMenu(categoryName);
      List<String> videosNames = [];

      for(int i = 0; i < tempVideosNames.length; i++){
        if(tempVideosNames[i].contains(keyword)){
          videosNames.add(tempVideosNames[i]);
        }
      }

      if(keyword.isNotEmpty) {
        emit(state.copyWith(totalVideosInCurrentCategory: videos.length));
        emit(state.copyWith(videos: videos, videosNames: videosNames));
      }
      else{
        emit(state.copyWith(totalVideosInCurrentCategory: tempVideos.length));
        emit(state.copyWith(videos: tempVideos, videosNames: tempVideosNames));
      }
    }
  }


  FutureOr<void> _refreshListsSubirVideoMenu(RefreshListsSubirVideoMenuEvent event, Emitter<UploadVideoMenuState> emit) async {
    await dataRepo.listItemsSectoresMenu();

    List<String> categories = await dataRepo.getCategoriesSectoresMenu();

    emit(state.copyWith(totalCategories: categories.length, categories: categories, currentCategory: -1));
  }


  FutureOr<void> _searchVideosSubirVideoMenu(SearchEventSubirVideoMenu event, Emitter<UploadVideoMenuState> emit) {
    emit(state.copyWith(searchedKeyword: event.searchedKeyword));
  }
}







