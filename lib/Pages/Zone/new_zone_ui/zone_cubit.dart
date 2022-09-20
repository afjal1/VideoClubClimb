import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videoclubclimb/Pages/Zone/new_zone_ui/zone_bloc_provider.dart';
import 'package:videoclubclimb/models/File.dart';

import '../../../data_repo.dart';
import '../zone_videos/zone_videos_bloc.dart';
import 'zone_state.dart';

class ZoneHereCubit extends Cubit<ZoneHereState> {
  ZoneHereCubit({this.repository}) : super(InitialState());
  final ZoneHereDataProvider? repository;

  int page = 0;
  DataRepo dataRepo = DataRepo();

//to load all the files within a category
  void loadedVideos(String category) {
    if (state is FileLoadingState) return;
    final currrentState = state;
    TotalFile? oldFile;
    if (currrentState is SuccessState) {
      oldFile = currrentState.response!;
    }

    emit(FileLoadingState(oldFile, isFirstFetch: page == 0));
    repository!.getVideosFiles(category, page).then((newFiles) {
      page++;
      final data = (state as FileLoadingState).response;

      if (data == null) {
        emit(SuccessState(
            response: TotalFile(
          files: (newFiles.files!),
          images: newFiles.images,
          videoUrls: newFiles.videoUrls,
        )));
      } else {
        data.files!.addAll(newFiles.files!);
        data.images!.addAll(newFiles.images!);
        data.videoUrls!.addAll(newFiles.videoUrls!);
        emit(SuccessState(response: data));
      }
    });
  }

  //to delete all the files within a category
  void deleteAllFiles(String category) {
    emit(DeleteLoadingState());
    repository!.deleteAllCategory(category).then((value) {
      emit(InitialState());
    });
  }

//filter files with grades
  Future<void> filterFiles(String category, String grade) async {
    int gradeValue = mapGradeToIndex(grade);
    List<File> filteredFiles = [];
    List<String> filteredImages = [];
    List<String> filteredVideoUrls = [];
    final currrentState = state;
    TotalFile? oldFile;
    if (currrentState is SuccessState) {
      oldFile = currrentState.response!;
    }

    for (int i = 0; i < oldFile!.files!.length; i++) {
      if (oldFile.files![i].grade == gradeValue) {
        filteredFiles.add(oldFile.files![i]);
        filteredImages.add(oldFile.images![i]);
        filteredVideoUrls.add(oldFile.videoUrls![i]);
      }
    }

    emit(SuccessState(
        response: TotalFile(
      files: (filteredFiles),
      images: filteredImages,
      videoUrls: filteredVideoUrls,
    )));
  }
}
