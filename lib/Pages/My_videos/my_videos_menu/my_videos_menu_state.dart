class MyVideoMenuFormSubmitting extends MyVideosMenuState {
  MyVideoMenuFormSubmitting(
      {required List<String> categories,
      required List<String> videos,
      required List<String> videosNames})
      : super(categories: categories, videos: videos, videosNames: videosNames);
}

class MyVideosMenuState {
  int totalCategories;
  int currentCategory;
  int totalVideosInCurrentCategory;
  List<String> categories;
  List<String> videos;
  List<String> videosNames;
  String searchedKeyword;

  String namesubirfoto;

  MyVideosMenuState({
    this.totalCategories = 0,
    this.currentCategory = -1,
    this.totalVideosInCurrentCategory = 0,
    this.searchedKeyword = '',
    required this.categories,
    required this.videos,
    required this.videosNames,
    this.namesubirfoto = '',
  });

  MyVideosMenuState copyWith({
    int? totalCategories,
    int? currentCategory,
    int? totalVideosInCurrentCategory,
    List<String>? categories,
    List<String>? videos,
    List<String>? videosNames,
    String? searchedKeyword,
    String? name,
  }) {
    return MyVideosMenuState(
      totalCategories: totalCategories ?? this.totalCategories,
      currentCategory: currentCategory ?? this.currentCategory,
      totalVideosInCurrentCategory:
          totalVideosInCurrentCategory ?? this.totalVideosInCurrentCategory,
      categories: categories ?? this.categories,
      videos: videos ?? this.videos,
      videosNames: videosNames ?? this.videosNames,
      searchedKeyword: searchedKeyword ?? this.searchedKeyword,
      namesubirfoto: name ?? namesubirfoto,
    );
  }
}
