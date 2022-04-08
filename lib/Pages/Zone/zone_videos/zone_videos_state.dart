import 'package:videoclubclimb/Pages/Zone/zone_videos/zone_videos_event.dart';
import 'package:videoclubclimb/auth/form_submission_state.dart';
import 'package:videoclubclimb/models/File.dart';

enum SearchBy { name, grado }

class ZoneVideosState {

  /// New

  List<File> files;
  int totalFiles;
  List<File> searchedVideos;
  List<String> images;
  List<String> videoUrls;
  /// =================


  int totalCategories;
  int currentCategory;
  int totalVideosInCurrentCategory;
  List<String> categories;

  String searchedKeyword;

  bool isSearching;
  SearchBy searchBy;

  FormSubmissionState formSubmissionState;

  ZoneVideosState({

    /// new

    required this.files,
    this.totalFiles = 0,
    required this.searchedVideos,
    required this.images,
    required this.videoUrls,
    /// ===================

    this.isSearching = false,
    this.totalCategories = 0,
    this.currentCategory = -1,
    this.totalVideosInCurrentCategory = 0,
    required this.categories,
    this.searchedKeyword = '',
    this.searchBy = SearchBy.name,
    this.formSubmissionState = const InitialFormState(),
  });

  ZoneVideosState copyWith({

    /// NEW

    List<File>? files,
    int? totalFiles,
    List<File>? searchedVideos,
    List<String>? images,
    List<String>? videoUrls,

    /// ================

    int? totalCategories,
    int? currentCategory,
    int? totalVideosInCurrentCategory,
    List<String>? categories,
    String? searchedKeyword,
    bool? isSearching,
    SearchBy? searchBy,
    FormSubmissionState? formSubmissionState,
  }) {
    return ZoneVideosState(

      /// NEW

      files: files?? this.files,
      totalFiles: totalFiles?? this.totalFiles,
      searchedVideos: searchedVideos?? this.searchedVideos,
      images: images?? this.images,
      videoUrls: videoUrls?? this.videoUrls,

      /// ==========
      totalCategories: totalCategories ?? this.totalCategories,
      currentCategory: currentCategory ?? this.currentCategory,
      totalVideosInCurrentCategory:
          totalVideosInCurrentCategory ?? this.totalVideosInCurrentCategory,
      categories: categories ?? this.categories,
      searchedKeyword: searchedKeyword ?? this.searchedKeyword,
      isSearching: isSearching ?? this.isSearching,
      searchBy: searchBy ?? this.searchBy,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
