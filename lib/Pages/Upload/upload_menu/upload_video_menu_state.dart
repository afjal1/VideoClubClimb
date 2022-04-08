class UploadVideoMenuState {
  int totalCategories;
  int currentCategory;
  int totalVideosInCurrentCategory;
  List<String> categories;
  List<String> videos;
  List<String> videosNames;
  String searchedKeyword;

  UploadVideoMenuState({
    this.totalCategories = 0,
    this.currentCategory = -1,
    this.totalVideosInCurrentCategory = 0,
    this.searchedKeyword = '',
    required this.categories,
    required this.videos,
    required this.videosNames,
  });

  UploadVideoMenuState copyWith({
    int? totalCategories,
    int? currentCategory,
    int? totalVideosInCurrentCategory,
    List<String>? categories,
    List<String>? videos,
    List<String>? videosNames,
    String? searchedKeyword,
  }) {
    return UploadVideoMenuState(
      totalCategories: totalCategories ?? this.totalCategories,
      currentCategory: currentCategory ?? this.currentCategory,
      totalVideosInCurrentCategory:
      totalVideosInCurrentCategory ?? this.totalVideosInCurrentCategory,
      categories: categories?? this.categories,
      videos: videos?? this.videos,
      videosNames: videosNames?? this.videosNames,
      searchedKeyword: searchedKeyword?? this.searchedKeyword,
    );
  }
}
