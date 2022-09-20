// ignore_for_file: must_be_immutable

import 'package:videoclubclimb/auth/form_submission_state.dart';
import 'package:videoclubclimb/models/File.dart';

enum SearchBy { name, grado }

class FormSubmitting1 extends ZoneVideosState {
  FormSubmitting1(
      {required List<File> files,
      required List<File> searchedVideos,
      required List<String> images,
      required List<String> videoUrls,
      required List<String> categories})
      : super(
          files: files,
          searchedVideos: searchedVideos,
          images: images,
          videoUrls: videoUrls,
          categories: categories,
        );
}

class ZoneVideosState {
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
  bool? firstFetch;

  String searchedKeyword;

  bool isSearching;
  SearchBy searchBy;

  FormSubmissionState formSubmissionState;
  List<String> searchImages;
  List<String> searchVideoUrls;

  // @override
  // List<Object> get props => [
  //       files,
  //       totalFiles,
  //       searchedVideos,
  //       images,
  //       videoUrls,
  //       totalCategories,
  //       currentCategory,
  //       totalVideosInCurrentCategory,
  //       categories,
  //       searchedKeyword,
  //       isSearching,
  //       searchBy,
  //       formSubmissionState,
  //       searchImages,
  //       searchVideoUrls,
  //     ];

  ZoneVideosState({
    /// new

    required this.files,
    this.totalFiles = 0,
    this.firstFetch,
    required this.searchedVideos,
    this.searchVideoUrls = const [],
    this.searchImages = const [],
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
    List<File>? totalVideos,
    List<String>? images,
    List<String>? videoUrls,
    List<File>? searchedVideos,
    List<String>? searchImages,
    List<String>? searchVideoUrls,

    /// ================

    int? totalCategories,
    bool? firstFetch,
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
      searchVideoUrls: searchVideoUrls ?? this.searchVideoUrls,

      searchImages: searchImages ?? this.searchImages,
      files: files ?? this.files,
      totalFiles: totalFiles ?? this.totalFiles,
      searchedVideos: totalVideos ?? this.searchedVideos,
      images: images ?? this.images,
      videoUrls: videoUrls ?? this.videoUrls,

      /// ==========
      totalCategories: totalCategories ?? this.totalCategories,
      firstFetch: firstFetch ?? this.firstFetch,
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

  ZoneVideosState isLoading({
    /// NEW

    List<File>? files,
    int? totalFiles,
    List<File>? totalVideos,
    List<String>? images,
    List<String>? videoUrls,
    List<File>? searchedVideos,
    List<String>? searchImages,
    List<String>? searchVideoUrls,

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
      searchVideoUrls: searchVideoUrls ?? this.searchVideoUrls,
      searchImages: searchImages ?? this.searchImages,
      files: files ?? this.files,
      totalFiles: totalFiles ?? this.totalFiles,
      searchedVideos: totalVideos ?? this.searchedVideos,
      images: images ?? this.images,
      videoUrls: videoUrls ?? this.videoUrls,

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

//New Way

//cubit


//


