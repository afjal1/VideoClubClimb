import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../data_repo.dart';
import 'my_videos_menu_event.dart';
import 'my_videos_menu_state.dart';


class MyVideosMenuBloc extends Bloc<MyVideosMenuEvent, MyVideosMenuState>{

  DataRepo dataRepo;

  MyVideosMenuBloc({required this.dataRepo}) : super(MyVideosMenuState(categories: [], videos: [], videosNames: [])){

    on<CategoryClickedMyVideosMenuEvent>(_getVideosInACategoryMyVideosMenu);
    on<GetCategoriesMyVideosMenuEvent>(_getCategoriesMyVideosMenu);
  }


  _getCategoriesMyVideosMenu(GetCategoriesMyVideosMenuEvent event, Emitter<MyVideosMenuState> emit) async {

    List<String> categories = await dataRepo.getCategoriesSectoresMenu();

    emit(state.copyWith(totalCategories: categories.length, categories: categories));
  }

  FutureOr<void> _getVideosInACategoryMyVideosMenu(CategoryClickedMyVideosMenuEvent event, Emitter<MyVideosMenuState> emit) {

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
}







