import 'package:videoclubclimb/auth/form_submission_state.dart';

class ZoneMenuFormSubmitting extends ZoneMenuState {
  ZoneMenuFormSubmitting(
      {required List<String> categories,
      required List<String> videos,
      required List<String> videosNames})
      : super(categories: categories, videos: videos, videosNames: videosNames);
}

class ZoneMenuState {
  int totalCategories;
  int currentCategory;
  int totalVideosInCurrentCategory;
  List<String> categories;
  List<String> videos;
  List<String> videosNames;
  String searchedKeyword;
  FormSubmissionState formSubmissionState;
  bool deleting;

  ZoneMenuState({
    this.deleting = false,
    this.totalCategories = 0,
    this.currentCategory = -1,
    this.totalVideosInCurrentCategory = 0,
    this.searchedKeyword = '',
    required this.categories,
    required this.videos,
    required this.videosNames,
    this.formSubmissionState = const InitialFormState(),
  });

  ZoneMenuState copyWith(
      {int? totalCategories,
      int? currentCategory,
      int? totalVideosInCurrentCategory,
      List<String>? categories,
      List<String>? videos,
      List<String>? videosNames,
      String? searchedKeyword,
      FormSubmissionState? formSubmissionState,
      bool? deleting}) {
    return ZoneMenuState(
      deleting: deleting ?? this.deleting,
      totalCategories: totalCategories ?? this.totalCategories,
      currentCategory: currentCategory ?? this.currentCategory,
      totalVideosInCurrentCategory:
          totalVideosInCurrentCategory ?? this.totalVideosInCurrentCategory,
      categories: categories ?? this.categories,
      videos: videos ?? this.videos,
      videosNames: videosNames ?? this.videosNames,
      searchedKeyword: searchedKeyword ?? this.searchedKeyword,
      formSubmissionState: formSubmissionState ?? this.formSubmissionState,
    );
  }
}
